#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]]; then
	echo "usage: $0 <VARIABLE_PREFIX>"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

mkdir -p ${WORK_DIR}

bash ${current}/prepare/clone.sh ${1}
