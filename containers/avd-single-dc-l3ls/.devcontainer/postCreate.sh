#!/usr/bin/env bash

set +e

# replace all markdown vars in demo directory
grep -rl '{{gh.repo_name}}' . --exclude-dir .git | xargs sed -i 's/'{{gh.repo_name}}'/'"${GITHUB_REPOSITORY##*/}"'/g'
grep -rl '{{gh.org_name}}' . --exclude-dir .git | xargs sed -i 's/'{{gh.org_name}}'/'"${GITHUB_REPOSITORY%%/*}"'/g'
grep -rl '{{gh.repository}}' . --exclude-dir .git | xargs sed -i 's@'{{gh.repository}}'@'"${GITHUB_REPOSITORY}"'@g'

ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker

# copy AVD inventory
mkdir ${CONTAINERWSF}/avd_inventory/
cp -r /home/avd/.ansible/collections/ansible_collections/arista/avd/examples/single-dc-l3ls/* ${CONTAINERWSF}/avd_inventory/

# init demo dir as Git repo if requested for this demo env
if ${GIT_INIT}; then
  cd ${CONTAINERWSF}
  git init
  git config --global --add safe.directory ${PWD}
  if [ -z "$(git config user.name)" ]; then git config user.name "Lab User"; fi
  if [ -z "$(git config user.email)" ]; then git config user.email user@one-click.lab; fi
  git add .
  git commit -m "git init"
fi
