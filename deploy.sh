#!/usr/bin/env sh
set -e
npm run build
cd dist
git init
git add -A
git commit -m 'deploy'
git push -f "https://github.com/LeeCH-OeO/TW_COVID_maps.git" master:gh-pages
cd -