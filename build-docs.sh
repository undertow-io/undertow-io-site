#!/bin/bash
set -e

# Build undertow-docs for all versions and place them in static/undertow-docs
# Requires: git, maven, java, graphviz

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="$SCRIPT_DIR/static/undertow-docs"
TMP_DIR=$(mktemp -d)

# Use Java 11 for compatibility with older asciidoctor-maven-plugin
export JAVA_HOME="${JAVA_HOME_11:-/Users/yoda/.sdkman/candidates/java/11.0.30-librca}"
export PATH="$JAVA_HOME/bin:$PATH"
echo "Using Java: $(java -version 2>&1 | head -1)"

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$DOCS_DIR"

build_docs() {
    local BRANCH=$1
    local VERSION=$2

    echo "========================================"
    echo "Building docs for branch: $BRANCH -> version: $VERSION"
    echo "========================================"

    git clone --depth 1 --branch "$BRANCH" https://github.com/undertow-io/undertow-docs.git "$TMP_DIR/docs-$VERSION"

    cd "$TMP_DIR/docs-$VERSION"
    mvn clean package -DskipTests -q

    # Copy the built docs
    rm -rf "$DOCS_DIR/undertow-docs-$VERSION"
    cp -r target/generated-docs "$DOCS_DIR/undertow-docs-$VERSION"

    # Create zip file
    cd "$DOCS_DIR"
    rm -f "undertow-docs-$VERSION.zip"
    zip -rq "undertow-docs-$VERSION.zip" "undertow-docs-$VERSION"

    echo "Done: undertow-docs-$VERSION"
    echo ""
}

# Build docs for each version
# Map: branch -> version name used on site
build_docs "2.0" "2.0.0"
build_docs "1.3.0" "1.3.0"
build_docs "1.2.0" "1.4.0"  # Note: Using 1.2.0 branch for 1.4.0 docs

echo "========================================"
echo "All documentation built successfully!"
echo "Output directory: $DOCS_DIR"
ls -la "$DOCS_DIR"
