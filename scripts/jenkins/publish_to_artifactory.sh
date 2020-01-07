#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR

BUILD_NUMBER=$1

if [ -z "$BUILD_NUMBER" ]; then
  echo "Usage: $(basename $0) <build number> <build date>"
  echo ""
  echo "    The build date must be suitable for use in a file name."
  exit 1
fi

# Configure default NPM registry so that `npm audit` can evaluate packages.
npm config set registry http://registry.npmjs.org/
# Configure where NPM will publishing the library.
npm config set @drc-eca:registry http://artifactory/artifactory/api/npm/drc_local_npm/
# Publish the library to artifactory.

version=$(dirname $0)/version.sh
echo "\n\n\n\n\n\n\n\n\n\n\n HOW IS THIS DONE? \n\n\n\n\n\n\n\n\n\n\n"
