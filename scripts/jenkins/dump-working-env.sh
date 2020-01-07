#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR

uname -psr
uname -a
node --version
npm --version
# Cannot run ts-node until `npm install` is run.
# ts-node --version

env | sort
