#!/usr/bin/env bash

timestamp=`date "+%Y%m%d-%H%M%S"`

echo "updating static content: $timestamp"

# clear the old static site
rm -rf docs/*

# scrape the new static content
wget -r -nH -P docs -E -T 2 -np -k http://localhost:2368/

# fix all the broken links
grep -rli 'http://localhost:2368' docs/* | xargs -I@ sed -i '' 's|http://localhost:2368|https://codenerve.com|g' @

# create a 404
echo "---" >> docs/404.md
echo "permalink: /404.html" >> docs/404.md
echo "---" >> docs/404.md
cp content/404.html docs/

# setup google ads
cp content/ads.txt docs/

# add the CNAME to keep custom domain routing
echo "codenerve.com" >> docs/CNAME

# commit and tag the update
git add docs
git commit -m "updating static content: $timestamp"
git tag -a $timestamp -m "version $timestamp"
git push
git push origin --tags
