#!/bin/bash
set -e

# Local deployment script
# For CI/CD, use the GitHub Action in .github/workflows/deploy.yml

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Build docs if not present
if [ ! -d "static/undertow-docs/undertow-docs-2.0.0" ]; then
    echo "Documentation not found. Building docs first..."
    ./build-docs.sh
fi

# Clean previous build
rm -rf public

# Build the Hugo site
hugo --minify

echo ""
echo "Site built successfully in ./public"
echo ""
echo "To deploy to gh-pages manually:"
echo "  git checkout gh-pages"
echo "  rsync -avr --delete --exclude '.git' --exclude 'CNAME' public/ ."
echo "  git add -A && git commit -m 'publish changes' && git push"
echo "  git checkout master"
echo ""
echo "Or just push to master and let GitHub Actions handle deployment."
