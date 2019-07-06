#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <TAG>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

TAG=${1}

if [[ ! -f ${TAG_DIR}/${TAG}/package.json ]] || [[ ! -d ${TAG_DIR}/${TAG}/packages ]]; then
	echo "tag is not exists"
	exit 1
fi

if [[ -f ${VERSION_DIR}/${TAG}.json ]]; then
	exit
fi

echo ""
echo ">> ${TAG}"

jq -sc . $(find ${TAG_DIR}/${TAG}/packages/*.json -maxdepth 1 -type f)\
 | jq -rc '[ .[] | {key:.name, value:.version} ] | from_entries'\
 | sed 's/@wordpress\//wp-/g'\
 > ${VERSION_DIR}/${TAG}.json
