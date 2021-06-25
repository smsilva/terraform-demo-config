#!/bin/bash
REPOSITORY_NAME=$1
VERSION=$2

DOWNLOAD_DIRECTORY="${TEMP_INFRA_STACK_SOURCE_CODE?}/${REPOSITORY_NAME?}-${VERSION?}"

if [ ! -e ${DOWNLOAD_DIRECTORY?} ]; then
  REMOTE_FILE_NAME="v${VERSION?}.tar.gz"

  LOCAL_FILE_NAME="${TEMP_INFRA_STACK_SOURCE_CODE?}/${REPOSITORY_NAME?}-${REMOTE_FILE_NAME?}"

  REMOTE_FILE_URI="https://github.com/smsilva/${REPOSITORY_NAME}/archive/refs/tags/${REMOTE_FILE_NAME}"

  echo "[Source Code] Downloading"
  echo "${REMOTE_FILE_URI?}"

  wget \
      --quiet "${REMOTE_FILE_URI?}" \
      --output-document ${LOCAL_FILE_NAME?}

  echo ""
  echo "[Source Code] Extracting"
  echo "${LOCAL_FILE_NAME?} to ${TEMP_INFRA_STACK_SOURCE_CODE?}"

  tar xvf ${LOCAL_FILE_NAME?} --directory=${TEMP_INFRA_STACK_SOURCE_CODE?}

  [ -e ${LOCAL_FILE_NAME?} ] && rm ${LOCAL_FILE_NAME?}

  echo ""
fi
