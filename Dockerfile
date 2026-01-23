FROM alpine:3.19 AS builder

# Install dependencies (Java 11 for compatibility with older asciidoctor-maven-plugin)
RUN apk add --no-cache \
    git \
    hugo \
    openjdk11 \
    maven \
    graphviz \
    bash \
    zip

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

WORKDIR /build

# Copy site source
COPY . /build/site

# Script to build docs for a specific branch/version
RUN cat > /build/build-docs.sh << 'EOF'
#!/bin/bash
set -e

BRANCH=$1
VERSION=$2
DOCS_DIR=/build/site/static/undertow-docs

mkdir -p $DOCS_DIR

echo "Building docs for branch: $BRANCH, version: $VERSION"

# Clone the specific branch
git clone --depth 1 --branch $BRANCH https://github.com/undertow-io/undertow-docs.git /tmp/docs-$VERSION

cd /tmp/docs-$VERSION

# Build with Maven
mvn clean package -DskipTests

# Copy the built docs
cp -r target/generated-docs $DOCS_DIR/undertow-docs-$VERSION

# Create zip file
cd $DOCS_DIR
zip -r undertow-docs-$VERSION.zip undertow-docs-$VERSION

echo "Docs built successfully for version $VERSION"
EOF
RUN chmod +x /build/build-docs.sh

# Build docs for each version
RUN /build/build-docs.sh 2.0 2.0.0
RUN /build/build-docs.sh 1.3.0 1.3.0
RUN /build/build-docs.sh 1.2.0 1.4.0

# Build Hugo site
WORKDIR /build/site
RUN hugo --minify

# Production image with just the static files
FROM nginx:alpine

COPY --from=builder /build/site/public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
