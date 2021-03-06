#!/bin/bash
set -e

DOWNLOAD_GIT_REPO_NAME=$1
DOWNLOAD_RELEASE_VERSION=$2
DOWNLOAD_SOURCE_CODE_DIRECTORY=$3
DOWNLOAD_RELEASE_DIRECTORY="${DOWNLOAD_SOURCE_CODE_DIRECTORY?}/${DOWNLOAD_GIT_REPO_NAME?}-${DOWNLOAD_RELEASE_VERSION?}"
DOWNLOAD_RELEASE_REMOTE_FILE="v${DOWNLOAD_RELEASE_VERSION?}.tar.gz"
DOWNLOAD_FILE="${DOWNLOAD_SOURCE_CODE_DIRECTORY?}/${DOWNLOAD_GIT_REPO_NAME?}-${DOWNLOAD_RELEASE_REMOTE_FILE}"
REMOTE_FILE_URI="https://github.com/smsilva/${DOWNLOAD_GIT_REPO_NAME}/archive/refs/tags/${DOWNLOAD_RELEASE_REMOTE_FILE}"

echo "Download"
echo ""
echo "  Parameters"
echo "    DOWNLOAD_GIT_REPO_NAME.........: ${DOWNLOAD_GIT_REPO_NAME}"
echo "    DOWNLOAD_RELEASE_VERSION.......: ${DOWNLOAD_RELEASE_VERSION}"
echo "    DOWNLOAD_SOURCE_CODE_DIRECTORY.: ${DOWNLOAD_SOURCE_CODE_DIRECTORY}"
echo "    DOWNLOAD_RELEASE_REMOTE_FILE...: ${DOWNLOAD_RELEASE_REMOTE_FILE}"
echo "    DOWNLOAD_RELEASE_DIRECTORY.....: ${DOWNLOAD_RELEASE_DIRECTORY}"
echo "    DOWNLOAD_FILE..................: ${DOWNLOAD_FILE}"
echo ""

if [ ! -e ${DOWNLOAD_RELEASE_DIRECTORY?} ]; then
  mkdir -p ${DOWNLOAD_SOURCE_CODE_DIRECTORY?}

  wget \
      --quiet "${REMOTE_FILE_URI?}" \
      --output-document ${DOWNLOAD_FILE?}

  echo ""
  echo "  Unpack"
  echo "    ${DOWNLOAD_FILE?} to ${DOWNLOAD_SOURCE_CODE_DIRECTORY?}"
  echo ""

  tar xvf ${DOWNLOAD_FILE?} --directory=${DOWNLOAD_SOURCE_CODE_DIRECTORY?}

  [ -e ${DOWNLOAD_FILE?} ] && rm ${DOWNLOAD_FILE?}

  echo ""
else
  echo "  Release Directory already exists"
  echo "    ${DOWNLOAD_RELEASE_DIRECTORY?}"
  echo ""
fi

echo ""
