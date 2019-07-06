#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <TAG> [PACKAGE]"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh

TAG=${1}
PACKAGE=${2-""}

COMMIT=$(git -C ${WORK_DIR}/${PLUGIN_SLUG} log -1 --format=format:"%H" ${TAG})

if [[ -z "${PACKAGE}" ]]; then
	FILE=package.json
else
	FILE=packages/${PACKAGE}/package.json
fi

git -C ${WORK_DIR}/${PLUGIN_SLUG} show ${COMMIT}:${FILE} | jq -c .
