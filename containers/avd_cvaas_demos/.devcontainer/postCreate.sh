#!/usr/bin/env bash

set +e

CVTOKEN=$(curl -H "Authorization: Bearer ${CV_API_TOKEN}" "https://www.cv-staging.corp.arista.io/api/v3/services/admin.Enrollment/AddEnrollmentToken" -d '{"enrollmentToken":{"reenrollDevices":["*"],"validFor":"24h"}}' | sed -n 's|.*"token":"\([^"]*\)".*|\1|p')
echo "$CVTOKEN" > ${CONTAINERWSF}/clab/cv-onboarding-token
ardl get eos --image-type cEOS --version ${CEOS_LAB_VERSION}  --import-docker
