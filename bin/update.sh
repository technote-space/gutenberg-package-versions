#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)

bash ${current}/update/prepare.sh
bash ${current}/update/get.sh
bash ${current}/update/processing.sh
bash ${current}/update/commit.sh
