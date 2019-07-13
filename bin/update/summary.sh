#!/usr/bin/env bash

set -e

current=$(cd $(dirname $0);
pwd)
source ${current}/../variables.sh

gutenberg_tag=$(bash ${current}/common/get-last-tag.sh GUTENBERG)
gutenberg_tag_url=${GH_PAGES_URL}/gutenberg/tags/${gutenberg_tag}.json
wordpress_tag=$(bash ${current}/common/get-last-tag.sh WP)
wordpress_tag_url=${GH_PAGES_URL}/wp-core/tags/${wordpress_tag}.json
last_updated_at=$(LANG="C" TZ=":UTC" date '+%e %B %Y %T UTC')
last_updated_at_url=${TRAVIS_BUILD_WEB_URL:-'/'}

bash ${current}/summary/readme.sh "${gutenberg_tag}" "${gutenberg_tag_url}" "${wordpress_tag}" "${wordpress_tag_url}" "${last_updated_at}" "${last_updated_at_url}"
bash ${current}/summary/api.sh "${gutenberg_tag}" "${gutenberg_tag_url}" "${wordpress_tag}" "${wordpress_tag_url}" "${last_updated_at}" "${last_updated_at_url}"
