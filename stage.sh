#!/usr/bin/env bash

timestamp=`date "+%Y%m%d-%H%M%S"`

echo "staging static content: $timestamp"

rm -rf docs/*
wget -r -nH -P docs -E -T 2 -np -k http://localhost:2368/
