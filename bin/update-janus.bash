#! /usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

cd "${HOME}/.janus"

for dir in $(ls)
do
  (
  cd $dir

  echo "----------------------------------------------"
  echo $dir
  echo "----------------------------------------------"

  echo git pull
  git pull

  if [[ -e .gitmodules ]]; then
    echo git submodule update
    git submodule update
  fi

  echo ""
  )
done
