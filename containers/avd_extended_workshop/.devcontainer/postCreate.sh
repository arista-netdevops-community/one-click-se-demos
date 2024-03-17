#!/usr/bin/env bash

set +e

ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker
