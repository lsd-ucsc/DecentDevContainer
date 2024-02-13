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
		python3=3.10.6-1~22.04 \
		python3-pip=22.0.2+dfsg-1ubuntu0.4 \
		golang=2:1.18~0ubuntu2

# Python packages
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install \
	web3==6.15.1\
	requests==2.31.0 \
	numpy==1.26.4 \
	matplotlib==3.8.2 \
	plotly==5.18.0 \
	kaleido==0.2.1 \
	pandas==2.2.0 \
	cryptography==42.0.2

# Node.js
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor > /etc/apt/trusted.gpg.d/nodesource.gpg
RUN echo "deb https://deb.nodesource.com/node_20.x jammy main" >> /etc/apt/sources.list.d/nodesource.list
RUN echo "deb-src https://deb.nodesource.com/node_20.x jammy main" >> /etc/apt/sources.list.d/nodesource.list
RUN apt update -y
RUN apt install -y nodejs=20.5.1-deb-1nodesource1

# Node.js packages
RUN npm install -g ganache@7.9.2

# Solc compiler
RUN curl -fsSL -o /bin/solc https://github.com/ethereum/solidity/releases/download/v0.8.24/solc-static-linux
RUN chmod 755 /bin/solc

# APT clean up
RUN apt-get autoremove -y
RUN apt-get clean all
################################################################################

ENV DEBIAN_FRONTEND=

ENV LANG=C.UTF-8
