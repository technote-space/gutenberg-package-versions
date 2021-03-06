#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

pushd ${DATA_DIR}
echo ""
echo ">> Create zip file."
zip -9 -qr ${GITHUB_WORKSPACE}/${RELEASE_FILE} .
pushd

ls -la ${RELEASE_FILE}
