# deploy-to-master.sh
#! /bin/bash

rm -rf _book
npm run build

cd dist
git init
git add .
git commit -m 'Travis build'
git push --force --quiet "https://${GITHUB_TOKEN}@github.com/[user]/[repository name].git" master:gh-pages


