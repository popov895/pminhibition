#!/bin/bash

mkdir -p po

xgettext \
    `find . -name \*.js -o -name \*.qml` \
    --keyword=i18n:1 \
    --keyword=i18nc:1c,2 \
    --keyword=i18np:1,2 \
    --keyword=i18ncp:1c,2,3 \
    --from-code=UTF-8 \
    --output=po/example.pot

for file in po/*.po
do
    msgmerge -Uq --backup=off "$file" po/example.pot
done
