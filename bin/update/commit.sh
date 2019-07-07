#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

if [[ ! -d ${DATA_DIR} ]]; then
	echo "versions are empty"
	exit 1
fi

echo ""
echo ">> Commit"
if [[ -z "${CI}" ]]; then
	echo "Prevent commit if local"
	exit
fi

echo ""
echo ">> Check diff"
git -C ${TRAVIS_BUILD_DIR} checkout master
if [[ -z "$(git -C ${TRAVIS_BUILD_DIR} status --short ${DATA_DIR})" ]]; then
	echo "There is no diff"
	exit
fi

git -C ${TRAVIS_BUILD_DIR} add ${DATA_DIR}
git -C ${TRAVIS_BUILD_DIR} status
git -C ${TRAVIS_BUILD_DIR} commit --quiet -m "${COMMIT_MESSAGE}"

echo ""
echo ">> Create new tag"
bash ${current}/commit/get-new-tag.sh | xargs --no-run-if-empty -I {} git tag -a {} -m "${TAG_MESSAGE}"

echo ""
echo ">> Push"
git -C ${TRAVIS_BUILD_DIR} push origin master --tags
