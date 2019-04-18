#!/bin/sh

curr_br=$(git branch | cut -c3-)
BRANCH=${curr_br:=develop}
# Run the required submodule bookkeeping.
git submodule update --recursive --init --jobs 2
# Checkout the HEAD of the branch.
git submodule foreach --recursive "echo -e '\n'; git checkout $BRANCH"
# Set git to use the latest version of the rtm-service and rtm-ui projects. If neither changed this does nothing.
git add service ui  &&  git commit -m 'Updates to latest versions of submodules'  &&  git push

echo -e '\n\nCurrent module versions: (commit) (name) (fixed version)'
git submodule status --recursive


