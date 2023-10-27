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
		net-tools \
		iputils-ping \
		build-essential \
		git \
		cmake \
		python3 \
		python3-pip \
		curl

# SSH Server
RUN apt-get update -y && \
	apt-get install -y \
		openssh-server
RUN rm /etc/ssh/ssh_host_*

# SGX PSW
RUN curl \
	-o /opt/sgx_debian_local_repo.tgz \
	-fSL https://download.01.org/intel-sgx/latest/linux-latest/distro/ubuntu22.04-server/sgx_debian_local_repo.tgz

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
	-o /opt/sgx_linux_x64_sdk_2.20.100.4.bin \
	-fSL https://download.01.org/intel-sgx/latest/linux-latest/distro/ubuntu22.04-server/sgx_linux_x64_sdk_2.20.100.4.bin
RUN chmod 755 /opt/sgx_linux_x64_sdk_2.20.100.4.bin
RUN /opt/sgx_linux_x64_sdk_2.20.100.4.bin --prefix /opt/intel

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
