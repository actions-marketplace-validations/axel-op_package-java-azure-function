#!/bin/bash

set -Eeuo pipefail

mvn --batch-mode -DappName="${APP_NAME}" package com.microsoft.azure:azure-functions-maven-plugin:package

# This is the Maven "target" directory
BUILD_DIR=$(mvn help:evaluate -Dexpression=project.build.directory -q -DforceStdout)

DEPLOYMENT_DIR_ABS="${BUILD_DIR}/azure-functions/${APP_NAME}"
DEPLOYMENT_FILE_ABS="${DEPLOYMENT_DIR_ABS}.zip"

zip -r "${DEPLOYMENT_FILE_ABS}" "${DEPLOYMENT_DIR_ABS}"

echo "deployment-directory=${DEPLOYMENT_DIR_ABS}" >> $GITHUB_OUTPUT
echo "deployment-file=${DEPLOYMENT_FILE_ABS}" >> $GITHUB_OUTPUT
