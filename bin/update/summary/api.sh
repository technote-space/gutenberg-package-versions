#!/usr/bin/env bash

set -e

if [[ $# -lt 6 ]]; then
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ""

echo ""
echo ">> Update latest info api"
gutenberg_tag=${1}
gutenberg_tag_url=${2}
wordpress_tag=${3}
wordpress_tag_url=${4}
last_updated_at=${5}
last_updated_at_url=${6}

API=${DATA_DIR}/summary.json
rm -f ${README}

gutenberg='{"tag":"'${gutenberg_tag}'","url":"'${gutenberg_tag_url}'"}'
wp='{"tag":"'${wordpress_tag}'","url":"'${wordpress_tag_url}'"}'
update='{"date":"'${last_updated_at}'","url":"'${last_updated_at_url}'"}'

echo '{"gutenberg":'${gutenberg}',"wp":'${wp}',"last_updated":'${update}'}' | jq -rc . > ${API}
