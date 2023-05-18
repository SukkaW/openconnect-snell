#!/bin/bash

# Credits: Roy Li (https://github.com/geekdada)
# Source from: https://github.com/geekdada/snell-server-docker/blob/master/get_url.sh

set -e

VERSION=$1
ARCH=$2

if [ "${ARCH}" == "amd64" ]; then
  echo "https://dl.nssurge.com/snell/snell-server-v${VERSION}-linux-amd64.zip"
elif [ "${ARCH}" == "arm64" ]; then
  echo "https://dl.nssurge.com/snell/snell-server-v${VERSION}-linux-aarch64.zip"
elif [ "${ARCH}" == "arm" ]; then
  echo "https://dl.nssurge.com/snell/snell-server-v${VERSION}-linux-armv7l.zip"
else
  echo "Usage: get-snell-url.sh VERSION ARCH"
  exit 1
fi

exit 0
