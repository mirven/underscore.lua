cp -r docs docs.tmp
git checkout gh-pages
cp docs.tmp/* .
rm -rf docs.tmp
git commit -a -m "update pages"
git push origin gh-pages
git checkout master