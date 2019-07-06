#!/usr/bin/env bash

set -e

if [[ -z "${TRAVIS_BUILD_DIR}" ]]; then
	echo "<TRAVIS_BUILD_DIR> is required"
	exit 1
fi

WORK_DIR=${TRAVIS_BUILD_DIR}/.work
DATA_DIR=${TRAVIS_BUILD_DIR}/data
TAG_DIR=${WORK_DIR}/tags
VERSION_DIR=${DATA_DIR}
VERSION_FILE=versions.json

GITHUB_REPO=WordPress/gutenberg
PLUGIN_SLUG=gutenberg
TAG_MESSAGE="Auto tag by Travis CI"
if [[ -n "${TRAVIS_BUILD_NUMBER}" ]]; then
	COMMIT_MESSAGE="feat: Update version data (Travis build: ${TRAVIS_BUILD_WEB_URL})"
else
	COMMIT_MESSAGE="feat: Update version data"
fi
