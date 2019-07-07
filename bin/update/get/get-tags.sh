#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

if [[ ! -d ${TARGET_DIR}/.git ]]; then
	echo "There is not repository: ${TARGET_DIR}"
	exit 1
fi

if [[ ! -d ${TARGET_DIR}/.git ]]; then
	echo "Not prepared: ${TARGET_DIR}"
	exit 1
fi

git -C ${TARGET_DIR} tag | grep "^v\?[0-9]\+\.[0-9]\+\.[0-9]\+"
