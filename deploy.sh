#!/bin/sh

rm -r _site
bundle exec awestruct -P production --force
rsync -rv  --protocol=28 --delete _site/ undertow@http2.undertow.io:/opt/undertow/site
