#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

if [[ ! -d ${TARGET_PUBLISH_TAGS_DIR} ]]; then
	echo "version files are not exists"
	exit 1
fi

echo ""
echo ">> Create tags list"
find ${TARGET_PUBLISH_TAGS_DIR}/*.json -maxdepth 1 -type f -print0\
 | xargs -0 -I filename basename filename .json\
 | jq -Rsc '. | split("\n") | map(select(length > 0))'\
 > ${TARGET_PUBLISH_TAGS_FILE}

echo ""
echo ">> Merge ${TARGET_NAME} version files"
find ${TARGET_PUBLISH_TAGS_DIR}/*.json -maxdepth 1 -type f -print0\
 | xargs -0 -I filename basename filename .json\
 | xargs -I tag_name jq -s '{"tag_name":.[]}' ${TARGET_PUBLISH_TAGS_DIR}/tag_name.json\
 | jq -sc add\
 > ${TARGET_PUBLISH_VERSION_FILE}
