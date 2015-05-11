#!/bin/sh

rm -r _site
bundle exec awestruct -P production --force
#bundle exec awestruct -P production --deploy
rsync -rv  --protocol=28 --exclude='undertow-docs' --delete _site/ undertow@filemgmt.jboss.org:/www_htdocs/undertow
