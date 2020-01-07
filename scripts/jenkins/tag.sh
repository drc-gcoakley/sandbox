#!/bin/sh -x
trap 'echo "Script error: $?"; exit 1' ERR

BUILD_NUMBER=$1
SCM_URL=$2``

if [ -z "$SCM_URL" ] || [ -z "$BUILD_NUMBER" ]; then
  echo "Usage: $(basename $0) <SCM URL> <build number> <build date>"
  echo ""
  echo "    The build date must be suitable for use in a file name."
  exit 1
fi

version=$(dirname $0)/version.sh
git tag -a 2.1.${BUILD_NUMBER} -m "Jenkins $GIT_BRANCH branch build"
SCM_SSH_URL=$(echo $SCM_URL | awk -Fcom/ '{ print $2; }')

echo "SCM_URL= $SCM_URL"
echo "SCM_SSH_URL= $SCM_SSH_URL"
git push git@github.com:${SCM_SSH_URL} --tags
