#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

if [[ ! -d ${DATA_DIR} ]]; then
	echo "Data not found"
	exit 1
fi

echo ""
echo ">> Prepare files"
mkdir -p ${GH_PAGES_DIR}/${GH_PAGES_API_ROOT}
cp -a ${DATA_DIR} ${GH_PAGES_DIR}/${GH_PAGES_API_ROOT}/${GH_PAGES_API_VERSION}
cp ${TRAVIS_BUILD_DIR}/README.md ${GH_PAGES_DIR}/
echo ${GH_PAGES_CNAME} > ${GH_PAGES_DIR}/CNAME

if [[ -z "${CI}" ]]; then
	echo "Prevent commit if local"
	exit
fi

echo ""
echo ">> Commit"
git -C ${GH_PAGES_DIR} init
git -C ${GH_PAGES_DIR} add --all
git -C ${GH_PAGES_DIR} status --short
git -C ${GH_PAGES_DIR} commit -m "${COMMIT_MESSAGE}"

echo ""
echo ">> Push"
git -C ${TRAVIS_BUILD_DIR} push --force "https://github.com/${TRAVIS_REPO_SLUG}.git" master:gh-pages
