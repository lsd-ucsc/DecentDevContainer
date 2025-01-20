#!/bin/bash

set -e

DRAWIO_VERSION="26.0.4"
ARCH_NAME=$(uname -m)
if [ "$ARCH_NAME" == "x86_64" ]; then
	ARCH_NAME="amd64"
elif [ "$ARCH_NAME" == "aarch64" ]; then
	ARCH_NAME="arm64"
fi


# Download and install draw.io
curl -o drawio-${ARCH_NAME}-${DRAWIO_VERSION}.deb \
	-fSL \
	https://github.com/jgraph/drawio-desktop/releases/download/v${DRAWIO_VERSION}/drawio-${ARCH_NAME}-${DRAWIO_VERSION}.deb
dpkg -i ./drawio-${ARCH_NAME}-${DRAWIO_VERSION}.deb
rm drawio-${ARCH_NAME}-${DRAWIO_VERSION}.deb

