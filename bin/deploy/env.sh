#!/usr/bin/env bash

set -e

if [[ -z "${TRAVIS_BUILD_DIR}" ]]; then
	echo "<TRAVIS_BUILD_DIR> is required"
	exit 1
fi

export RELEASE_FILE=data.zip
export RELEASE_TITLE=${TRAVIS_TAG}
export RELEASE_TAG=${TRAVIS_TAG}
export RELEASE_BODY="Auto updated (Travis build: ${TRAVIS_BUILD_WEB_URL})"
