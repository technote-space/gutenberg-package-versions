#!/usr/bin/env bash

set -e

if [[ -z "${TRAVIS_BUILD_DIR}" ]]; then
	echo "<TRAVIS_BUILD_DIR> is required"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/variables.sh

echo ""
echo ">> Get Packages"
bash ${current}/get/get-tags.sh | while read tag;
do
	bash ${current}/get/get-packages.sh ${tag}
done
