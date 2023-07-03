#!/bin/bash

packageNamespace=`kreadconfig5 --file="$PWD/metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Name"`
packageVersion=`kreadconfig5 --file="$PWD/metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Version"`
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

zip -r ../$plasmoidFileName contents metadata.desktop
