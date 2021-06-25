#!/bin/bash
echo "[RELEASE] ${ENVIRONMENT?}-${STACK_VERSION?} [${TERRAFORM_CONFIGURATION_FILE?}]"
echo ""

echo "  Branch: ${ENVIRONMENT?}"

cd ${TEMP_INFRA_STACK_LIVE?}

git checkout ${ENVIRONMENT?}

git checkout sandbox

git pull --rebase

cd - > /dev/null
echo ""

ENVIRONMENT_LIVE_DIRECTORY="${TEMP_INFRA_STACK_LIVE?}/src"

echo "  Removing old environment: ${ENVIRONMENT_LIVE_DIRECTORY?}/*"
sudo rm -rf ${ENVIRONMENT_LIVE_DIRECTORY?}/*
tree ${ENVIRONMENT_LIVE_DIRECTORY?}
mkdir -p ${TEMP_INFRA_STACK_LIVE?}
echo ""

PROJECT_SOURCE_CODE_DIRECTORY="${TEMP_INFRA_STACK_SOURCE_CODE?}/${GIT_REPOSITORY_STACK?}-${STACK_VERSION?}"

echo "  Copying the Stack Source Code ${PROJECT_SOURCE_CODE_DIRECTORY?} to ${ENVIRONMENT_LIVE_DIRECTORY?}"
echo ""

cp -r ${PROJECT_SOURCE_CODE_DIRECTORY?} ${ENVIRONMENT_LIVE_DIRECTORY?}

echo "  Copying the ${TERRAFORM_CONFIGURATION_FILE?} configuration file to ${ENVIRONMENT_LIVE_DIRECTORY?}/"
cp ${TERRAFORM_CONFIGURATION_FILE?} ${ENVIRONMENT_LIVE_DIRECTORY?}/

echo ""
echo ""
