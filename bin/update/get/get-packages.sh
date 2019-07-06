#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <TAG>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh

TAG=${1}

if [[ ! -f ${TAG_DIR}/${TAG}/package.json ]]; then
	echo ""
	echo ">>>> ${TAG}"
	mkdir -p ${TAG_DIR}/${TAG}

	bash ${current}/get-package.sh ${TAG} > ${TAG_DIR}/${TAG}/package.json
fi

< ${TAG_DIR}/${TAG}/package.json jq -r '.dependencies|values[]' | grep "^file:packages/" | xargs -n1 --no-run-if-empty basename | while read -r package;
do
	if [[ ! -f ${TAG_DIR}/${TAG}/packages/${package}.json ]]; then
		echo ">>>> ${TAG}/${package}"
		mkdir -p ${TAG_DIR}/${TAG}/packages
		bash ${current}/get-package.sh ${TAG} ${package} > ${TAG_DIR}/${TAG}/packages/${package}.json
	fi
done
