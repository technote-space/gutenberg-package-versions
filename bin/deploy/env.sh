#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

export RELEASE_FILE1=data.zip
export RELEASE_FILE2=${VERSION_FILE}
export RELEASE_TITLE=${TRAVIS_TAG}
export RELEASE_TAG=${TRAVIS_TAG}
export RELEASE_BODY="Auto updated (Travis build: ${TRAVIS_BUILD_WEB_URL})"
