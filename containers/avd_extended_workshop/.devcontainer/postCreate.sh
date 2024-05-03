#!/usr/bin/env bash

set +e

# replace all markdown vars in demo directory
grep -rl 'https://.*.github.io/one-click-se-demos/' . --exclude-dir .git | xargs sed -i 's/https:\/\/.*.github.io\/one-click-se-demos/https:\/\/'"${GITHUB_REPOSITORY%%/*}"'.github.io\/one-click-se-demos/g'
grep -rl 'https://github.com/.*/one-click-se-demos' . --exclude-dir .git | xargs sed -i 's/https:\/\/github.com\/.*\/one-click-se-demos/https:\/\/github.com\/'"${GITHUB_REPOSITORY%%/*}"'\/one-click-se-demos/g'
grep -rl '{{gh.repo_name}}' . --exclude-dir .git | xargs sed -i 's/{{gh.repo_name}}/'"${GITHUB_REPOSITORY##*/}"'/g'
grep -rl '{{gh.org_name}}' . --exclude-dir .git | xargs sed -i 's/{{gh.org_name}}/'"${GITHUB_REPOSITORY%%/*}"'/g'
grep -rl '{{gh.repository}}' . --exclude-dir .git | xargs sed -i 's@{{gh.org_name}}@'"${GITHUB_REPOSITORY}"'@g'

ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker
