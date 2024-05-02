#!/usr/bin/env bash

set +e

ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker

# init demo dir as Git repo if requested for this demo env
if ${GIT_INIT}; then
  cd ${CONTAINERWSF}
  git init
  git add .
  git commit -m "git init"
fi
