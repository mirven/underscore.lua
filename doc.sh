#!/bin/sh
# ~/.luarocks/bin/luadoc lib/* -d doc -doclet 'doclet.mirven'

~/.luarocks/bin/luadoc lib/* -d doc -t template
mkdir -p docs
cp doc/files/lib/underscore.html docs/index.html
cp doc/luadoc.css docs/main.css
rm -rf doc
