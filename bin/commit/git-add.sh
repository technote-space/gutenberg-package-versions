#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

bash ${current}/../update/summary.sh

git -C ${2} add ${DATA_DIR}
git -C ${2} add ${GITHUB_WORKSPACE}/README.md
