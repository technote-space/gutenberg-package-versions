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

find ${VERSION_DIR}/*.json -maxdepth 1 -type f -print0\
 | xargs --no-run-if-empty -0 -I filename basename filename .json\
 | xargs -I {} jq -s '{"'{}'":.[]}' ${VERSION_DIR}/{}.json\
 | jq -sc .\
 > ${TRAVIS_BUILD_DIR}/${VERSION_FILE}
