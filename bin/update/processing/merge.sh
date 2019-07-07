#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

if [[ ! -d ${TARGET_VERSION_DIR} ]]; then
	echo "version files are not exists"
	exit 1
fi

echo ""
echo ">> Merge ${TARGET_NAME} version files"
find ${TARGET_VERSION_DIR}/*.json -maxdepth 1 -type f -print0\
 | xargs --no-run-if-empty -0 -I filename basename filename .json\
 | xargs -I tag jq -s '{"tag":.[]}' ${TARGET_VERSION_DIR}/tag.json\
 | jq -sc add\
 > ${TARGET_VERSION_FILE}
