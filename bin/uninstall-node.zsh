#!/bin/zsh

nodeRoot="/usr/local"
npmRoot="/usr/local/lib/node_modules/npm"

nodeFiles=($(lsbom -f -l -s -pf /var/db/receipts/org.nodejs.pkg.bom))
npmFiles=($(lsbom -f -l -s -pf /var/db/receipts/org.nodejs.node.npm.pkg.bom))

removeFile()
{
    dir="$1"
    file="$2"
    fullPath="${dir}/${file}"
    desc="$3"
    echo "Removing file (${desc}): ${fullPath}"

    if [[ -e ${fullPath} ]]; then
        echo "sudo rm -f ${fullPath}"
        sudo rm -rf ${fullPath}
    else
        echo "   File does not exist (ignoring)"
    fi
}

for file ($nodeFiles)
{
    removeFile $nodeRoot $file "node"
}

for file ($npmFiles)
{
    removeFile $npmRoot $file "npm"
}

echo "sudo rm -rf /usr/local/lib/node"
sudo rm -rf /usr/local/lib/node
echo "sudo rm -rf /usr/local/lib/node_modules"
sudo rm -rf /usr/local/lib/node_modules
echo "sudo rm -rf /var/db/receipts/org.nodejs.*"
sudo rm -rf /var/db/receipts/org.nodejs.*
