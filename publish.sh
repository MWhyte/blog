
timestamp=`date "+%Y%m%d-%H%M%S"`

echo "updating static content: $timestamp"

rm -rf docs/*
wget -r -nH -P docs -E -T 2 -np -k http://localhost:2368/

git add docs
git commit -m "updating static content: $timestamp"
git tag -a $timestamp -m "version $timestamp"
git push
git push origin --tags
