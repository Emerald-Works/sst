#!/usr/bin/env bash
time lerna bootstrap --ignore-scripts -- --prefer-offline --verbose
time lerna run build --stream
# time npx nx affected --target=build --all --parallel
CURRENT_VERSION=`cat lerna.json | jq -r '.version'`
VERSION_TIME=`date +%s`
export NEW_VERSION=$CURRENT_VERSION-local.$VERSION_TIME
echo $NEW_VERSION
time lerna version $NEW_VERSION --amend --no-git-tag-version --yes --exact --force-publish -- --verbose
time lerna publish $NEW_VERSION --amend --no-git-tag-version --yes --exact --dist-tag local --loglevel=trace
time lerna version $CURRENT_VERSION --amend --no-git-tag-version --yes --exact -- --verbose
