#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR
environment=$1
region=$2

if [ -z "$environment" ] || [ -z "$region" ]; then
  echo "Usage: $(basename $0) <environment> <region>"
  exit 1
fi

npm config set registry http://registry.npmjs.org
umask 0002 && npm install
umask 0022 && sls remove --stage ${environment} --region ${region} --verbose
