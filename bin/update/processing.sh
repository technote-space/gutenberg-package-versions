#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh ${1}

if [[ -d ${TARGET_WORK_TAG_DIR} ]]; then
	echo ""
	echo ">> Update ${TARGET_NAME} versions"

	bash ${current}/processing/get-versions.sh ${1}
	bash ${current}/processing/merge.sh ${1}
fi
