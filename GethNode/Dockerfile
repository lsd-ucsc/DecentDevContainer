# Copyright (c) 2023 Haofan Zheng
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

############################### Install packages ###############################
RUN apt-get update -y && \
	apt-get upgrade -y

RUN apt-get update -y && \
	apt-get install -y \
		apt-utils \
		lsb-release \
		python3 \
		python3-pip \
		openssl \
		curl

# Geth
ARG ETH_VER=1.13.14-2bd6bd01
RUN mkdir /opt/geth
RUN curl -fsSL https://gethstore.blob.core.windows.net/builds/geth-alltools-linux-amd64-${ETH_VER}.tar.gz \
	--output /opt/geth/geth.tar.gz
RUN echo $(sha256sum /opt/geth/geth.tar.gz)
RUN echo $(md5sum /opt/geth/geth.tar.gz)
RUN tar -xvzf /opt/geth/geth.tar.gz -C /opt/geth --strip-components=1
ENV PATH="/opt/geth:${PATH}"

# Prysm
ARG PRYSM_VER=v5.0.0
RUN mkdir /opt/prysm
RUN curl -L https://github.com/prysmaticlabs/prysm/raw/${PRYSM_VER}/prysm.sh \
	--output /opt/prysm/prysm.sh
RUN echo $(sha256sum /opt/prysm/prysm.sh)
RUN echo $(md5sum /opt/prysm/prysm.sh)
RUN chmod 755 /opt/prysm/prysm.sh

# Lighthouse
ARG LIGHTHOUSE_VER=v5.0.0
RUN mkdir /opt/lighthouse
RUN curl -L https://github.com/sigp/lighthouse/releases/download/${LIGHTHOUSE_VER}/lighthouse-${LIGHTHOUSE_VER}-$(uname -m)-unknown-linux-gnu.tar.gz \
	--output /opt/lighthouse/lighthouse-linux-gnu.tar.gz
RUN echo $(sha256sum /opt/lighthouse/lighthouse-linux-gnu.tar.gz)
RUN echo $(md5sum /opt/lighthouse/lighthouse-linux-gnu.tar.gz)
RUN tar -xvf /opt/lighthouse/lighthouse-linux-gnu.tar.gz -C /opt/lighthouse
RUN chmod 755 /opt/lighthouse/lighthouse

# staking-deposit-cli
ARG STAKE_CLI_VER=v2.7.0
ARG STAKE_CLI_HASH=fdab65d
RUN mkdir /opt/staking-deposit-cli
RUN export ARCH=`uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/` && \
	curl -L https://github.com/ethereum/staking-deposit-cli/releases/download/${STAKE_CLI_VER}/staking_deposit-cli-${STAKE_CLI_HASH}-linux-${ARCH}.tar.gz \
	--output /opt/staking-deposit-cli/staking-deposit-cli.tar.gz && \
	export ARCH=""
RUN echo $(sha256sum /opt/staking-deposit-cli/staking-deposit-cli.tar.gz)
RUN echo $(md5sum /opt/staking-deposit-cli/staking-deposit-cli.tar.gz)
RUN tar -xvf /opt/staking-deposit-cli/staking-deposit-cli.tar.gz --strip-components=2 -C /opt/staking-deposit-cli
################################################################################

ENV DEBIAN_FRONTEND=

ENV LANG=C.UTF-8

# environment
RUN mkdir /geth
WORKDIR /geth

# test script
# COPY test.sh /bin/test.sh
# RUN chmod 755 /bin/test.sh

# entrypoint
COPY init-geth /bin/init-geth
RUN chmod 755 /bin/init-geth

ENTRYPOINT [ "/bin/init-geth" ]
