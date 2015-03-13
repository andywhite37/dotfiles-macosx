#! /bin/bash

set -euo pipefail
IFS=$'\n\t'

cwd=$(pwd)
cd ~/dev/HaxeFoundation/haxelib
git pull
haxe haxelib.hxml
cd bin
nekotools boot haxelib.n
mv /usr/local/bin/haxelib /usr/local/bin/haxelib.orig
brew reinstall haxe --HEAD
mv /usr/local/bin/haxelib /usr/local/bin/haxelib.orig
ln -s ~/dev/HaxeFoundation/haxelib/bin/haxelib /usr/local/bin/haxelib
cd "${cwd}"
