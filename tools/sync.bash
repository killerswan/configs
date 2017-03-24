#! /bin/bash

set -o errexit
set -o nounset

upstream="$1"
repo="$2"

echo "Creating repos"
git clone "git@github.com:killerswan/${repo}.git" --origin kevin
#git -c transfer.fsckobjects=false clone "git@github.com:killerswan/${repo}.git" --origin kevin
pushd "${repo}"
git remote add upstream "https://github.com/${upstream}/${repo}.git"

echo "Fetching..."
git fetch kevin
git checkout master

echo "Merging upstream..."
git fetch upstream
git merge --ff-only upstream/master

echo "Pushing kevin..."
git push kevin master

echo OK

# oddities:
# vim-scripts all seem to be corrupt
