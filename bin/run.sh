#!/usr/bin/env bash

set -e

if [[ -z "${TRAVIS_BUILD_DIR}" ]]; then
	echo "<TRAVIS_BUILD_DIR> is required"
	exit 1
fi

current=$(cd $(dirname $0);
pwd)

bash ${current}/prepare.sh
bash ${current}/get.sh
bash ${current}/update.sh
