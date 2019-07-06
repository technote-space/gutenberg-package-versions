#!/usr/bin/env bash

set -ex

if [[ -z "${TRAVIS_BUILD_DIR}" ]]; then
	echo "<TRAVIS_BUILD_DIR> is required"
	exit 1
fi

pushd ${VERSION_DIR}
echo ""
echo ">> Create zip file."
zip -9 -qr ${TRAVIS_BUILD_DIR}/${RELEASE_FILE1} .
pushd

ls -la ${RELEASE_FILE1}
