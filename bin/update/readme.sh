#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh ${1}

gutenberg_tag=$(< ${DATA_DIR}/gutenberg/tags.json jq -r '.[]' | sed '/-/!{s/$/_/}' | sort -V | sed 's/_$//' | tail -n 1)
gutenberg_tag_url=https://${GH_PAGES_CNAME}/${GH_PAGES_API_ROOT}/${GH_PAGES_API_VERSION}/gutenberg/tags/${gutenberg_tag}.json
wordpress_tag=$(< ${DATA_DIR}/wp-core/tags.json jq -r '.[]' | sed '/-/!{s/$/_/}' | sort -V | sed 's/_$//' | tail -n 1)
wordpress_tag_url=https://${GH_PAGES_CNAME}/${GH_PAGES_API_ROOT}/${GH_PAGES_API_VERSION}/wp-core/tags/${wordpress_tag}.json
last_updated_at=$(LANG="C" TZ=":UTC" date '+%e %B %Y %T UTC')
last_updated_at_url=${TRAVIS_BUILD_WEB_URL:-'/'}

rm -f ${TRAVIS_BUILD_DIR}/README.md
cp ${current}/README.template.md ${TRAVIS_BUILD_DIR}/README.md
sed -i -e "s/\${gutenberg_tag}/${gutenberg_tag//\//\\/}/" ${TRAVIS_BUILD_DIR}/README.md
sed -i -e "s/\${gutenberg_tag_url}/${gutenberg_tag_url//\//\\/}/" ${TRAVIS_BUILD_DIR}/README.md
sed -i -e "s/\${wordpress_tag}/${wordpress_tag//\//\\/}/" ${TRAVIS_BUILD_DIR}/README.md
sed -i -e "s/\${wordpress_tag_url}/${wordpress_tag_url//\//\\/}/" ${TRAVIS_BUILD_DIR}/README.md
sed -i -e "s/\${last_updated_at}/${last_updated_at//\//\\/}/" ${TRAVIS_BUILD_DIR}/README.md
sed -i -e "s/\${last_updated_at_url}/${last_updated_at_url//\//\\/}/" ${TRAVIS_BUILD_DIR}/README.md
