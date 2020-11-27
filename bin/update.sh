#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/variables.sh

mkdir -p ${WORK_DIR}/tags
mkdir -p ${DATA_DIR}

bash ${current}/update/prepare.sh ${GUTENBERG_VARIABLE_PREFIX}&
bash ${current}/update/prepare.sh ${WP_VARIABLE_PREFIX}&
wait

bash ${current}/update/get.sh ${GUTENBERG_VARIABLE_PREFIX}&
bash ${current}/update/get.sh ${WP_VARIABLE_PREFIX}&
wait

bash ${current}/update/processing.sh ${GUTENBERG_VARIABLE_PREFIX}&
bash ${current}/update/processing.sh ${WP_VARIABLE_PREFIX}&
wait
