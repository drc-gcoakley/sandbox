#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR
environment=$1
region=$2

if [ -z "$environment" ]; then
  echo "Usage: $(basename $0) <environment>"
  exit 1
fi

$(/bin/sh $0)/build.sh ${environment}

# Add --prod to precompile templates
# https://angular.io/guide/deployment#enable-prod-mode
ng build -c=${environment} --outputHashing=all
