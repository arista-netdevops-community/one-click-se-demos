#!/usr/bin/env bash

set +e

# replace all markdown vars in demo directory
grep -rl '{{gh.repo_name}}' . --exclude-dir .git | xargs sed -i 's/{{gh.repo_name}}/'"${GITHUB_REPOSITORY##*/}"'/g'
grep -rl '{{gh.org_name}}' . --exclude-dir .git | xargs sed -i 's/{{gh.org_name}}/'"${GITHUB_REPOSITORY%%/*}"'/g'
grep -rl '{{gh.repository}}' . --exclude-dir .git | xargs sed -i 's@{{gh.repository}}@'"${GITHUB_REPOSITORY}"'@g'

ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker
