#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh

TAG=${1}

if [[ ! -d ${VERSION_DIR} ]]; then
	echo "version files are not exists"
	exit 1
fi

echo ""
echo ">> Merge version files"

find ${VERSION_DIR}/*.json -maxdepth 1 -type f\
 | xargs --no-run-if-empty -I filename basename filename .json\
 | xargs -I tag jq -s '{"'tag'":.[]}' ${VERSION_DIR}/tag.json\
 | jq -sc .\
 > ${TRAVIS_BUILD_DIR}/versions.json
