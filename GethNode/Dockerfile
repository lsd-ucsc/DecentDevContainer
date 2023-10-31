# Copyright (c) 2023 Haofan Zheng
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

############################### Install packages ###############################
RUN apt-get update -y && \
	apt-get install -y \
		apt-utils \
		lsb-release

RUN apt-get update -y && \
	apt-get upgrade -y

RUN apt-get update -y && \
	apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:ethereum/ethereum

# Geth
ARG ETH_VER=1.13.4+build29068+jammy
RUN apt-get update -y && \
	apt-get install -y \
		ethereum=${ETH_VER} \
		python3 \
		python3-pip \
		openssl \
		curl

# Prysm
ARG PRYSM_VER=v4.1.1
RUN mkdir /opt/prysm
RUN curl -L https://github.com/prysmaticlabs/prysm/raw/${PRYSM_VER}/prysm.sh \
	--output /opt/prysm/prysm.sh
RUN chmod 755 /opt/prysm/prysm.sh

# Lighthouse
ARG LIGHTHOUSE_VER=v4.5.0
RUN mkdir /opt/lighthouse
RUN curl -L https://github.com/sigp/lighthouse/releases/download/${LIGHTHOUSE_VER}/lighthouse-${LIGHTHOUSE_VER}-$(uname -m)-unknown-linux-gnu.tar.gz \
	--output /opt/lighthouse/lighthouse-linux-gnu.tar.gz
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
