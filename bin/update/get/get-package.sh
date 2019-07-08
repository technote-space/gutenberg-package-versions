#!/usr/bin/env bash

set -e

if [[ $# -lt 2 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX> <TAG> [PACKAGE]"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

TAG=${2}
PACKAGE=${3-""}

if [[ ! -d ${TARGET_WORK_REPO_DIR}/.git ]]; then
	exit 1
fi

COMMIT=$(git -C ${TARGET_WORK_REPO_DIR} log -1 --format=format:"%H" ${TAG})

if [[ -z "${PACKAGE}" ]]; then
	FILE=package.json
else
	FILE=packages/${PACKAGE}/package.json
fi

if [[ -n "$(git -C ${TARGET_WORK_REPO_DIR} cat-file -e ${COMMIT}:${FILE})" ]]; then
	exit
fi

git -C ${TARGET_WORK_REPO_DIR} cat-file -p ${COMMIT}:${FILE} | jq -c .
