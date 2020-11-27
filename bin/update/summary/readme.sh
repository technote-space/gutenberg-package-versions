#!/usr/bin/env bash

set -e

if [[ $# -lt 6 ]]; then
	exit 1
fi

current=$(cd $(dirname $0);
pwd)
source ${current}/../../variables.sh ""

echo ""
echo ">> Update README.md"
gutenberg_tag=${1}
gutenberg_tag_url=${2}
wordpress_tag=${3}
wordpress_tag_url=${4}
last_updated_at=${5}
last_updated_at_url=${6}

README=${GITHUB_WORKSPACE}/README.md
rm -f ${README}
cp ${current}/README.template.md ${README}
sed -i -e "s/\${gutenberg_tag}/${gutenberg_tag//\//\\/}/" ${README}
sed -i -e "s/\${gutenberg_tag_url}/${gutenberg_tag_url//\//\\/}/" ${README}
sed -i -e "s/\${wordpress_tag}/${wordpress_tag//\//\\/}/" ${README}
sed -i -e "s/\${wordpress_tag_url}/${wordpress_tag_url//\//\\/}/" ${README}
sed -i -e "s/\${last_updated_at}/${last_updated_at//\//\\/}/" ${README}
sed -i -e "s/\${last_updated_at_url}/${last_updated_at_url//\//\\/}/" ${README}
