# Copyright (c) 2023 Haofan Zheng
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

ARG BASE_IMG_TAG
FROM ghcr.io/lsd-ucsc/decent-sgxdev:$BASE_IMG_TAG

ENV DEBIAN_FRONTEND=noninteractive

############################### Install packages ###############################
RUN apt-get update -y && \
	apt-get install -y \
		python3 \
		python3-pip \
		golang

# Python packages
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install \
	web3==6.2.0 \
	requests==2.28.2 \
	numpy==1.24.3 \
	matplotlib==3.7.1 \
	plotly==5.14.1 \
	kaleido==0.2.1 \
	pandas==2.0.1 \
	cryptography==41.0.3

# Node.js
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor > /etc/apt/trusted.gpg.d/nodesource.gpg
RUN echo "deb https://deb.nodesource.com/node_18.x jammy main" >> /etc/apt/sources.list.d/nodesource.list
RUN echo "deb-src https://deb.nodesource.com/node_18.x jammy main" >> /etc/apt/sources.list.d/nodesource.list
RUN apt update -y
RUN apt install -y nodejs

# Node.js packages
RUN npm install -g ganache@7.8.0

# Solc compiler
RUN curl -fsSL -o /bin/solc https://github.com/ethereum/solidity/releases/download/v0.8.20/solc-static-linux
RUN chmod 755 /bin/solc

RUN apt-get clean all
################################################################################

ENV DEBIAN_FRONTEND=

ENV LANG=C.UTF-8
