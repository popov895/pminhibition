#!/bin/bash

packageNamespace=`jq -r ".KPlugin.Id" "$PWD/metadata.json"`
packageVersion=`jq -r ".KPlugin.Version" "$PWD/metadata.json"`
packageName="${packageNamespace##*.}"
localeFileName="plasma_applet_$packageNamespace"
plasmoidFileName="$packageName-$packageVersion.plasmoid"

for file in po/*.po
do
    locale=`basename ${file%.*}`
    localeFilePath="$PWD/contents/locale/$locale/LC_MESSAGES/$localeFileName.mo"
    mkdir -p "$(dirname "$localeFilePath")"
    msgfmt -o "$localeFilePath" "$file"
done

zip -r ../$plasmoidFileName contents metadata.json
