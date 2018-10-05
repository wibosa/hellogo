#!/usr/bin/env bash

# Makes unmaintainable Go plugin for phpstorm compatible with actual versions.
# https://github.com/go-lang-plugin-org/go-lang-idea-plugin
#
# Run ./go_compiler.sh path/to/downloaded/Go/plugin.zip version_of_phpstorm(e.g. 182, 173, etc.)
# For instance
# ./go_compiler.sh /home/user/downloads/Go-0.13.1947.zip 173
# New relevant file will be created in the same directory as initial archive. It will have name Go.zip.

TMP_DIR="`dirname $1`/tmp_go_compiler"
mkdir "$TMP_DIR"
cd "$TMP_DIR"
unzip $1

BUILD_DIR="tmp_build_dir"
mkdir "$BUILD_DIR"
cd "$BUILD_DIR"

INTELIJ_GO_FILE=`find "../Go/lib" -type f -name "intellij-go-*.jar"`
unzip "$INTELIJ_GO_FILE"

VERSION_LINE="<idea-version since-build=\"171.1834\" until-build=\"$2.*\"\/>"
sed -i '2s/.*/ '"$VERSION_LINE"' /' META-INF/plugin.xml

rm "$INTELIJ_GO_FILE"
zip -r $INTELIJ_GO_FILE .
cd ../
zip -r Go.zip Go
mv Go.zip ../
rm  -rfv "$TMP_DIR"