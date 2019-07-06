#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)

bash ${current}/deploy/create-zip.sh
