#!/bin/bash
# Build and run the Undertow documentation site

set -e

usage() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  build    Build the site and extract to ./public"
    echo "  serve    Build and serve the site on http://localhost:8080"
    echo "  clean    Remove build artifacts"
    echo ""
    echo "If no command is given, defaults to 'serve'"
}

build() {
    echo "Building site with Docker..."
    docker build --target builder -t undertow-site-builder .

    echo "Extracting built site..."
    docker create --name undertow-builder undertow-site-builder
    rm -rf ./public
    docker cp undertow-builder:/build/site/public ./public
    docker rm undertow-builder

    echo "Build complete. Output in ./public"
}

serve() {
    echo "Building site with Docker..."
    docker build -t undertow-site .

    echo "Starting server at http://localhost:8080"
    docker run --rm -p 8080:80 undertow-site
}

clean() {
    echo "Cleaning build artifacts..."
    rm -rf ./public
    docker rm -f undertow-builder 2>/dev/null || true
    docker rmi -f undertow-site undertow-site-builder 2>/dev/null || true
    echo "Clean complete"
}

case "${1:-serve}" in
    build)
        build
        ;;
    serve)
        serve
        ;;
    clean)
        clean
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        echo "Unknown command: $1"
        usage
        exit 1
        ;;
esac
