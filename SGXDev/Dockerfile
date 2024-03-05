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
	apt-get install -y \
		nano \
		less \
		unzip \
		net-tools \
		iputils-ping \
		git \
		curl \
		build-essential \
		cmake=3.22.1-1ubuntu1 \
		python3=3.10.6-1~22.04 \
		python3-venv=3.10.6-1~22.04 \
		python3-pip=22.0.2+dfsg-1ubuntu0.4

# SSH Server
RUN apt-get update -y && \
	apt-get install -y \
		openssh-server
RUN rm /etc/ssh/ssh_host_*

##########
# SGX Linux SDK
##########

ARG LINUX_SGX_VER=2.23
ARG SGX_SDK_VER=${LINUX_SGX_VER}.100.2

# SGX PSW
RUN curl \
	-o /opt/sgx_debian_local_repo.tgz \
	-fSL https://download.01.org/intel-sgx/sgx-linux/${LINUX_SGX_VER}/distro/ubuntu22.04-server/sgx_debian_local_repo.tgz

RUN tar -xzf /opt/sgx_debian_local_repo.tgz -C /opt
RUN echo 'deb [arch=amd64 trusted=yes] file:/opt/sgx_debian_local_repo/ jammy main' > /etc/apt/sources.list.d/intel-sgx.list
RUN apt-get update -y
RUN apt install -y \
	libsgx-enclave-common \
	libsgx-enclave-common-dbgsym \
	libsgx-urts \
	libsgx-urts-dbgsym \
	libsgx-epid \
	libsgx-uae-service

# AESM Service
COPY aesmd /etc/init.d/aesmd
RUN chmod 755 /etc/init.d/aesmd

# SGX SDK
RUN curl \
	-o /opt/sgx_linux_x64_sdk.bin \
	-fSL https://download.01.org/intel-sgx/sgx-linux/${LINUX_SGX_VER}/distro/ubuntu22.04-server/sgx_linux_x64_sdk_${SGX_SDK_VER}.bin
RUN chmod 755 /opt/sgx_linux_x64_sdk.bin
RUN /opt/sgx_linux_x64_sdk.bin --prefix /opt/intel

# APT clean up
RUN apt-get autoremove -y
RUN apt-get clean all
################################################################################

ENV DEBIAN_FRONTEND=

ENV LANG=C.UTF-8

# entrypoint
COPY sgx-init /bin/sgx-init
RUN chmod 755 /bin/sgx-init

ENTRYPOINT [ "/bin/sgx-init", "/bin/bash" ]
