#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

if [[ ! -d ${VERSION_DIR} ]]; then
	echo "versions are empty"
	exit 1
fi

echo ""
echo ">> Check diff"
if [[ -z "$(git -C ${TRAVIS_BUILD_DIR} status --short ${TRAVIS_BUILD_DIR}/data)" ]] && [[ -z "$(git -C ${TRAVIS_BUILD_DIR} status --short ${TRAVIS_BUILD_DIR}/${VERSION_FILE})" ]]; then
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
git -C ${TRAVIS_BUILD_DIR} add ${TRAVIS_BUILD_DIR}/${VERSION_FILE}
git -C ${TRAVIS_BUILD_DIR} status
git -C ${TRAVIS_BUILD_DIR} commit -m "${COMMIT_MESSAGE}"

echo ""
echo ">> Create new tag"
bash ${current}/commit/get-new-tag.sh | xargs --no-run-if-empty -I {} git tag -a {} -m "${TAG_MESSAGE}"

echo ""
echo ">> Push"
git -C ${TRAVIS_BUILD_DIR} push origin master --tags
