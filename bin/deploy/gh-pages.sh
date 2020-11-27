#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

echo ""
echo ">> Prepare files"
mkdir -p ${GH_PAGES_DIR}/${GH_PAGES_API_ROOT}/${GH_PAGES_API_VERSION}
rm -f ${GH_PAGES_DIR}/README.md
rm -f ${GH_PAGES_DIR}/CNAME
rsync -a --checksum --delete ${DATA_DIR}/ ${GH_PAGES_DIR}/${GH_PAGES_API_ROOT}/${GH_PAGES_API_VERSION}/
cp ${GITHUB_WORKSPACE}/README.md ${GH_PAGES_DIR}/
echo ${GH_PAGES_CNAME} > ${GH_PAGES_DIR}/CNAME
