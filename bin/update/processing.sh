#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

if [[ ! -d ${TAG_DIR} ]]; then
	echo "packages are empty"
	exit 1
fi

echo ""
echo ">> Update versions"
mkdir -p ${VERSION_DIR}
find ${TAG_DIR} -maxdepth 1 -type d | xargs -n1 --no-run-if-empty basename | grep -v "tags" | while read tag;
do
	if [[ -f ${TAG_DIR}/${tag}/package.json ]] && [[ -d ${TAG_DIR}/${tag}/packages ]]; then
		bash ${current}/update/get-versions.sh ${tag}
	fi
done

bash ${current}/update/merge.sh
