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

RUN apt-get update -y && \
	apt-get install -y \
		ethereum=1.13.4+build29068+jammy \
		python3 \
		python3-pip \
		openssl \
		curl


# Prysm
RUN mkdir /opt/prysm
RUN curl -L https://github.com/prysmaticlabs/prysm/raw/v4.1.1/prysm.sh \
	--output /opt/prysm/prysm.sh
RUN chmod 755 /opt/prysm/prysm.sh
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
