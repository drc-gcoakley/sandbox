#!/bin/sh -x

curr_br=$(git branch | cut -c3-)
BRANCH=${curr_br:=develop}
// Run the required submodule bookkeeping.
git submodule update --recursive --init --jobs 2
# Checkout the HEAD of the branch.
git submodule foreach --recursive "echo -e '\n'; git checkout $BRANCH"

echo -e '\n\nModules: (commit) (name) (fixed version)'
git submodule status --recursive


