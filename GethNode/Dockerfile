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

# Version configurations
ARG ETH_VER=1.13.4+build29068+jammy
ARG PRYSM_VER=v4.1.1
ARG LIGHTHOUSE_VER=v4.5.0

# Geth
RUN apt-get update -y && \
	apt-get install -y \
		ethereum=${ETH_VER} \
		python3 \
		python3-pip \
		openssl \
		curl

# Prysm
RUN mkdir /opt/prysm
RUN curl -L https://github.com/prysmaticlabs/prysm/raw/${PRYSM_VER}/prysm.sh \
	--output /opt/prysm/prysm.sh
RUN chmod 755 /opt/prysm/prysm.sh

# Lighthouse
RUN mkdir /opt/lighthouse
RUN curl -L https://github.com/sigp/lighthouse/releases/download/${LIGHTHOUSE_VER}/lighthouse-${LIGHTHOUSE_VER}-$(uname -m)-unknown-linux-gnu.tar.gz \
	--output /opt/lighthouse/lighthouse-linux-gnu.tar.gz
RUN tar -xvf /opt/lighthouse/lighthouse-linux-gnu.tar.gz -C /opt/lighthouse
RUN chmod 755 /opt/lighthouse/lighthouse
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
