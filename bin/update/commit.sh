#!/usr/bin/env bash

set -ex

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

if [[ ! -d ${VERSION_DIR} ]]; then
	echo "versions are empty"
	exit 1
fi

echo ""
echo ">> Check diff"
if [[ -z "$(git -C ${TRAVIS_BUILD_DIR} status --short ${TRAVIS_BUILD_DIR}/data)" ]]; then
	echo "There is no diff"
	exit
fi

echo ""
echo ">> Commit"
if [[ -z "${CI}" ]]; then
	echo "Prevent commit if local"
	exit
fi
git -C ${TRAVIS_BUILD_DIR} add ${TRAVIS_BUILD_DIR}/data
git -C ${TRAVIS_BUILD_DIR} commit -m "${COMMIT_MESSAGE}"

echo ""
echo ">> Create new tag"
bash ${current}/commit/get-new-tag.sh | xargs --no-run-if-empty -I new_tag git tag new_tag

echo ""
echo ">> Push"
git push origin master --tags
