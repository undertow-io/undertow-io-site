FROM alpine:3.19 AS builder

# Install dependencies (no Java/Maven needed!)
RUN apk add --no-cache \
    git \
    hugo \
    ruby \
    graphviz \
    bash

# Install asciidoctor and asciidoctor-pdf
RUN gem install asciidoctor asciidoctor-pdf --no-document

WORKDIR /build

# Copy site source
COPY . /build/site

# Generate PDF documentation
WORKDIR /build/site
RUN ./generate-pdfs.sh

# Build Hugo site (BASE_URL can be overridden for different deployments)
ARG BASE_URL
RUN if [ -n "$BASE_URL" ]; then hugo --minify --baseURL "$BASE_URL"; else hugo --minify; fi

# Production image with just the static files
FROM nginx:alpine

COPY --from=builder /build/site/public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
