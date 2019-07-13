#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

< ${DATA_DIR}/${TARGET_SLUG}/tags.json jq -r '.[]' | sed '/-/!{s/$/_/}' | sort -V | sed 's/_$//' | tail -n 1
