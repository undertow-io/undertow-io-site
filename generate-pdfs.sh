#!/bin/bash
# Generate PDF documentation for each version using asciidoctor-pdf

set -e

VERSIONS="2.0.0 1.4.0 1.3.0"
OUTPUT_DIR="static/documentation/pdf"

# Create output directory
mkdir -p "$OUTPUT_DIR"

for VERSION in $VERSIONS; do
    echo "Generating PDF for version $VERSION..."
    asciidoctor-pdf \
        -a pdf-theme=default \
        -a imagesdir=images \
        -D "$OUTPUT_DIR" \
        -o "undertow-docs-$VERSION.pdf" \
        "docs/$VERSION/src/main/asciidoc/index.asciidoc"
done

echo "PDF generation complete. Files in $OUTPUT_DIR:"
ls -la "$OUTPUT_DIR"
