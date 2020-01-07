#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR
environment=$1

if [ -z "$environment" ]; then
  echo "Usage: $(basename $0) <environment>"
  exit 1
fi

# Commands that are quick or are specific to shell instances should not be guarded by: if ... built.txt ...
umask 0002
npm config set registry http://registry.npmjs.org

if [ ! -r built.txt ]; then
  rm -rf dist/
  npm install
  npm update
  npm run lint
  npm run build:setInfo
  date > built.txt
fi
