#!/bin/sh

rm -r _site
bundle exec awestruct -P production --force
#bundle exec awestruct -P production --deploy
#rsync -rv  --protocol=28  --delete --exclude undertow-docs _site/ undertow@filemgmt.jboss.org:/www_htdocs/undertow

# Push changes to gh-pages branch
git checkout gh-pages
git pull
rsync -avr _site .
git add -A
git commit -m "publish changes"
git push

# Go back to master branch
git checkout master