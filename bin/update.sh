#!/usr/bin/env bash

set -e

if [[ -z "${TRAVIS_BUILD_DIR}" ]]; then
	echo "<TRAVIS_BUILD_DIR> is required"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)

bash ${current}/update/prepare.sh
bash ${current}/update/get.sh
bash ${current}/update/processing.sh
bash ${current}/update/commit.sh
