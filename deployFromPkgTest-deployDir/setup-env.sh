#!/bin/sh
source $(dirname $0)/setup-env.sh

# Set to argument #3 if that is defined; otherwise set to the value of $Deploy_to_environments.
TARGET_ENVS=${3:-$Deploy_to_environments}
# Set to argument #2 if that is defined; otherwise set to the value of $BUILD_NUMBER.
BUILD_NUMBER=${2:-$BUILD_NUMBER}

# If this is running under Jenkins then $JENKINS_HOME will be set and this condition will be true.
if [ -n "$JENKINS_HOME" ]; then
	# If $BUILD_NUMBER is not set this condition will be true then, exit because it should be set.
	if [ -z "$BUILD_NUMBER" ]; then 
		echo "Environment variable BUILD_NUMBER must be passed in or set."; 
		exit 1; 
	fi
	TARGET_ENVS=${TARGET_ENVS:-Deploy_to_environments}
else
	# If $BUILD_NUMBER is not set this condition will be true then, exit because it should be set.
	if [ -z "$VERSION_ARG" ]; then 
		echo "Environment variable VERSION_ARG must be passed in."; 
		exit 1; 
	fi
	# This is being run from the command line to set a new version manually. Set some reasonable 
	# default values. The build number will be reset when run from Jenkins or a release tag is set.
	TARGET_ENVS=dev
	NOW=$(date '+%y%m%d.%H%M%S')
	BUILD_NUMBER=${BUILD_NUMBER:-$NOW}
fi

# Set to argument #1 if that is defined; otherwise set to the value in quotes.
VERSION_ARG=${1:-"prerelease --preid=$BUILD_NUMBER"}
CURRENT_VERSION=$(jq -r '.version' < package.json)

if [[ "${TARGET_ENVS}" =~ "prod" ]]; then
	# This is piped through 'tee' so the subshell returns a success status and does not abort 
	# this script (because of the 'trap' command).
	IS_PRERELEASE=$(echo $CURRENT_VERSION | grep -c -- '-' | tee) 
	if [ "$IS_PRERELEASE" -ge 1 ]; then
		# Assume the code was manually tagged sometime after the last release.
		# Remove the prerelease version / label / tag.
		VERSION_ARG=patch
	else
		# Assume the code was manually tagged just before the release build.
		# The version is not a pre-release so, it can be used as is. 
		VERSION_ARG=$CURRENT_VERSION
	fi
	# If the code was not tagged at all then npm will abort because the version did not change.
fi

NEW_VERSION=$(npm version $VERSION_ARG)
echo "Current version: $CURRENT_VERSION, version arg.: $VERSION_ARG, new version: $NEW_VERSION"

set -x
BRANCH=$(git rev-parse --abbrev-ref HEAD)
git tag -a $NEW_VERSION -m "Tagging version: $NEW_VERSION"
git push origin $BRANCH --follow-tags
