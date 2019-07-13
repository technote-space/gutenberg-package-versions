#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

git -C ${2} checkout master
git -C ${2} status --short ${DATA_DIR}
