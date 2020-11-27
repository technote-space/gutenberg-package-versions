#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh ${1}

echo ""
echo ">> Get ${TARGET_NAME} Packages"
bash ${current}/get/get-tags.sh ${1} | while read -r tag;
do
  normalized=${tag#v}
  echo ""
  echo "> ${normalized}"
  if [[ -f "${TARGET_PUBLISH_TAGS_DIR}"/"${normalized}".json ]]; then
    continue
  fi
	bash ${current}/get/get-packages.sh ${1} ${tag}
done
