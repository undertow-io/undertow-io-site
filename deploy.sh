#!/bin/sh

rm -r _site
bundle exec awestruct -P production --force
bundle exec awestruct -P production --deploy