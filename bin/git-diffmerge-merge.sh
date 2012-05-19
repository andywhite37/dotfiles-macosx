#! /bin/sh

basePath="$1"
localPath="$2"
remotePath="$3"
resultPath="$4"

if [ ! -f $basePath ]
then
    basePath="~/diffmerge-empty"
fi

"${HOME}/bin/diffmerge.sh" --merge --result="$resultPath" "$localPath" "$basePath" "$remotePath" --title1="Current Branch" --title2="Result: $4" --title3="Other Branch"
