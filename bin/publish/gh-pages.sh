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
echo ">> Clone gh-pages"
git clone -b gh-pages "https://github.com/${TRAVIS_REPO_SLUG}.git" ${GH_PAGES_DIR}

echo ""
echo ">> Prepare files"
mkdir -p ${GH_PAGES_DIR}/${GH_PAGES_API_ROOT}/${GH_PAGES_API_VERSION}
rm -f ${GH_PAGES_DIR}/README.md
rm -f ${GH_PAGES_DIR}/CNAME
rsync -a --checksum --delete ${DATA_DIR}/ ${GH_PAGES_DIR}/${GH_PAGES_API_ROOT}/${GH_PAGES_API_VERSION}/
cp ${TRAVIS_BUILD_DIR}/README.md ${GH_PAGES_DIR}/
echo ${GH_PAGES_CNAME} > ${GH_PAGES_DIR}/CNAME

echo ""
echo ">> Check diff"
if [[ -z "$(git -C ${GH_PAGES_DIR} status --short)" ]]; then
	echo "There is no diff"
	exit
fi

if [[ -z "${CI}" ]]; then
	git -C ${GH_PAGES_DIR} status --short
	echo "Prevent commit if local"
	exit
fi

echo ""
echo ">> Commit"
git -C ${GH_PAGES_DIR} add -a
git -C ${GH_PAGES_DIR} status --short
git -C ${GH_PAGES_DIR} commit -m "${COMMIT_MESSAGE}"

echo ""
echo ">> Push"
git -C ${GH_PAGES_DIR} push origin gh-pages
