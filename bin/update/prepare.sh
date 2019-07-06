#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

echo ""
echo ">> Clone Gutenberg"
if [[ ! -d ${WORK_DIR}/${PLUGIN_SLUG}/.git ]]; then
	mkdir -p ${WORK_DIR}
	git clone --depth=1 https://github.com/${GITHUB_REPO}.git ${WORK_DIR}/${PLUGIN_SLUG}
fi

echo ""
echo ">> Fetch"
git -C ${WORK_DIR}/${PLUGIN_SLUG} fetch -p --tags
git -C ${WORK_DIR}/${PLUGIN_SLUG} reset --hard origin/master
git -C ${WORK_DIR}/${PLUGIN_SLUG} pull
