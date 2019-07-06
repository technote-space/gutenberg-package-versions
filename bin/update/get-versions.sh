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

if [[ -f ${VERSION_DIR}/${TAG}/versions.json ]] && [[ -f ${VERSION_DIR}/${TAG}/packages.json ]]; then
	exit
fi

echo ""
echo ">> ${TAG}"
mkdir -p ${VERSION_DIR}/${TAG}
rm -f ${VERSION_DIR}/${TAG}/versions.json
rm -f ${VERSION_DIR}/${TAG}/packages.json

jq -s . $(find ${TAG_DIR}/${TAG}/packages/*.json -maxdepth 1 -type f) > ${VERSION_DIR}/${TAG}/packages.json
cat ${VERSION_DIR}/${TAG}/packages.json | jq -r '[ .[] | {key:.name, value:.version} ] | from_entries' | sed 's/@wordpress\//wp-/' > ${VERSION_DIR}/${TAG}/versions.json
