#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

echo ""
echo ">> Clone ${TARGET_NAME}"
if [[ ! -d ${TARGET_WORK_REPO_DIR}/.git ]]; then
	git clone --depth=1 https://github.com/${TARGET_REPO}.git ${TARGET_WORK_REPO_DIR}
fi

echo ""
echo ">> Fetch ${TARGET_NAME}"
git -C ${TARGET_WORK_REPO_DIR} fetch -p --tags
git -C ${TARGET_WORK_REPO_DIR} reset --hard origin/master
git -C ${TARGET_WORK_REPO_DIR} pull
