#!/bin/sh -x

curr_br=$(git branch | cut -c3-)
BRANCH=${curr_br:=develop}
git submodule update --recursive --init --jobs 2
git submodule foreach --recursive "echo -e '\n'; git checkout $BRANCH"
git submodule foreach --recursive "echo -e '\n'; git diff --submodule=log --no-color; git diff --shortstat origin/develop"

echo -e '\n\nModules: (commit) (name) (fixed version)'
git submodule status --recursive

# git submodule update --init
# git submodule foreach --recursive "git checkout $BRANCH"
# git submodule foreach "git pull"

