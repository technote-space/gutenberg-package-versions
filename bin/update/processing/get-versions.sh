#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

mkdir -p ${TARGET_VERSION_DIR}
find ${TARGET_TAG_DIR} -maxdepth 1 -type d -print0 | xargs -n1 --no-run-if-empty -0 basename | grep -v "tags" | while read -r tag;
do
	if [[ -f ${TARGET_TAG_DIR}/${tag}/package.json ]] && [[ -d ${TARGET_TAG_DIR}/${tag}/packages ]] && [[ ! -f ${TARGET_VERSION_DIR}/${tag}.json ]]; then
		echo ""
		echo ">> ${tag}"
		jq -sc . $(find ${TARGET_TAG_DIR}/${tag}/packages/*.json -maxdepth 1 -type f)\
		 | jq -rc '[ .[] | {key:.name, value:.version} ] | from_entries'\
		 | sed 's/@wordpress\//wp-/g'\
		 > ${TARGET_VERSION_DIR}/${tag}.json
	fi
done
