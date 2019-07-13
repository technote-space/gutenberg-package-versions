#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

git -C ${2} add ${DATA_DIR}
git -C ${2} add ${TRAVIS_BUILD_DIR}/README.md
