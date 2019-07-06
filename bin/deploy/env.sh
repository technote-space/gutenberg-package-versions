#!/usr/bin/env bash

set -e

if [[ -z "${TRAVIS_BUILD_DIR}" ]]; then
	echo "<TRAVIS_BUILD_DIR> is required"
	exit 1
fi

export DATA_DIR=${TRAVIS_BUILD_DIR}/data
export VERSION_DIR=${DATA_DIR}

export REPO_NAME=${TRAVIS_REPO_SLUG##*/}
export RELEASE_FILE1=data.zip
export RELEASE_FILE2=versions.json
export RELEASE_TITLE=${TRAVIS_TAG}
export RELEASE_TAG=${TRAVIS_TAG}
export RELEASE_BODY="Auto updated (Travis build: ${TRAVIS_BUILD_WEB_URL})"
