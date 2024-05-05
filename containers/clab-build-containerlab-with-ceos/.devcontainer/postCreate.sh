#!/usr/bin/env bash

set +e

# replace all markdown vars in demo directory
grep -rl '{{gh.repo_name}}' . --exclude-dir .git | xargs sed -i 's/{{gh.repo_name}}/'"${GITHUB_REPOSITORY##*/}"'/g'
grep -rl '{{gh.org_name}}' . --exclude-dir .git | xargs sed -i 's/{{gh.org_name}}/'"${GITHUB_REPOSITORY%%/*}"'/g'
grep -rl '{{gh.repository}}' . --exclude-dir .git | xargs sed -i 's@{{gh.repository}}@'"${GITHUB_REPOSITORY}"'@g'

ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker

# init demo dir as Git repo if requested for this demo env
if ${GIT_INIT}; then
  cd ${CONTAINERWSF}
  git config --global --add safe.directory .
  git init
  git add .
  git commit -m "git init"
fi
