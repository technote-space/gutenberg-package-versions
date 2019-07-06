#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh

if [[ ! -d ${WORK_DIR}/${PLUGIN_SLUG}/.git ]]; then
	echo "Not prepared"
	exit 1
fi

git -C ${WORK_DIR}/${PLUGIN_SLUG} tag | grep "^v[0-9]\+\.[0-9]\+\.[0-9]\+"
