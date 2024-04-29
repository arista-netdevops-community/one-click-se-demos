#!/usr/bin/env bash

set +e

CVTOKEN=$(curl -H "Authorization: Bearer ${CV_API_TOKEN}" "https://www.cv-staging.corp.arista.io/api/v3/services/admin.Enrollment/AddEnrollmentToken" -d '{"enrollmentToken":{"reenrollDevices":["*"],"validFor":"24h"}}' | sed -n 's|.*"token":"\([^"]*\)".*|\1|p')
echo "$CVTOKEN" > ${CONTAINERWSF}/clab/cv-onboarding-token
ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker


echo "alias dc1-leaf1-server1='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@172.16.1.201'" > ~/.zshrc
echo "alias dc1-leaf2-server1='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@172.16.1.202'" > ~/.zshrc

# init demo dir as Git repo if requested for this demo env
if ${GIT_INIT}; then
  cd ${CONTAINERWSF}
  git init
  git add .
  git commit -m "git init"
fi
