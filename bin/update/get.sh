#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

echo ""
echo ">> Get Packages"
bash ${current}/get/get-tags.sh | while read -r tag;
do
	bash ${current}/get/get-packages.sh ${tag}
done
