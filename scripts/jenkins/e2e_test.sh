#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR
environment=$1

$(dirname $0)/build.sh ${environment}

ng e2e
