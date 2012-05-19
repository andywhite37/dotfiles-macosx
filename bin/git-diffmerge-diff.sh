#! /bin/sh

echo "Entering git-diffmerge-diff.sh"

# Arguments to git diff are:
# $1 = path
# $2 = old-file
# $3 = old-hex
# $4 = old-mode
# $5 = new-file
# $6 = new-hex
# $7 = new-mode

path="$1"
old="$2"
new="$5"

echo "Launching DiffMerge..."
echo "Path = $path"
echo "Old = $old"
echo "New = $new"

"${HOME}/bin/diffmerge.sh" "$old" "$new" --title1="Old" --title2="New $path"
