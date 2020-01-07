#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR

NAME_ROOT=$1
BUILD_NUMBER=$2
SCM_URL=$3

if [ -z "$NAME_ROOT" ] || [ -z "$SCM_URL" ] || [ -z "$BUILD_NUMBER" ]; then
  echo "Usage: $(basename $0) <artifact name root> <SCM URL> <build number> <build date>"
  echo ""
  echo "    The build date must be suitable for use in a file name."
  exit 1
fi

$(dirname $0)/build.sh ${environment}

version=$(dirname $0)/version.sh
cd dist
zip -r ../${NAME_ROOT}-${version}.${BUILD_NUMBER}.zip *
cd ..
