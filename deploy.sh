#!/bin/sh

rm -r _site
awestruct -P production --force
awestruct -P production --deploy