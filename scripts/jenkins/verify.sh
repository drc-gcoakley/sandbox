#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR
PATH=./node_modules/.bin/

npm run vuln_check
