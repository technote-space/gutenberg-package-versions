#!/usr/bin/env bash

set -e

if [[ $# -lt 2 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX> <TAG>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ${1}

TAG=${2}
NORMALIZED_TAG=${TAG#v}

if [[ -n ${TARGET_IS_WP} ]]; then
	MAJOR=${NORMALIZED_TAG%%.*}
	if [[ ${MAJOR} -lt 5 ]]; then
		exit
	fi
fi

if [[ ! -f ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/package.json ]]; then
	echo ""
	echo ">>>> ${NORMALIZED_TAG}"
	mkdir -p ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}

	bash ${current}/get-package.sh ${1} ${TAG} > ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/package.json
fi

if [[ -n ${TARGET_IS_WP} ]]; then
	< ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/package.json jq -r '.dependencies | to_entries | .[] | select(.key | startswith("@wordpress")) | "\(.key) \(.value)"' | while read -r package version;
	do
		package_without_namespace=${package#@wordpress/}
		if [[ ! -f ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/packages/${package_without_namespace}.json ]]; then
			echo ">>>> ${NORMALIZED_TAG}/${package_without_namespace}"
			mkdir -p ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/packages
			echo "{\"name\":\"${package}\",\"version\":\"${version#^}\"}" > ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/packages/${package_without_namespace}.json
		fi
	done
else
	< ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/package.json jq -r '.dependencies | values[] | select(startswith("file:packages/"))' | xargs -n1 --no-run-if-empty basename | while read -r package;
	do
		if [[ ! -f ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/packages/${package}.json ]]; then
			echo ">>>> ${NORMALIZED_TAG}/${package}"
			mkdir -p ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/packages
			bash ${current}/get-package.sh ${1} ${TAG} ${package} > ${TARGET_WORK_TAG_DIR}/${NORMALIZED_TAG}/packages/${package}.json
		fi
	done
fi
