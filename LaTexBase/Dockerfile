# Copyright (c) 2024 Haofan Zheng
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

FROM ubuntu:24.04


ENV DEBIAN_FRONTEND=noninteractive

############################### Install packages ###############################

RUN apt-get update -y && \
	apt-get upgrade -y

RUN apt-get update -y && \
	apt-get install -y \
		build-essential \
		python3 \
		python3-pip \
		python3-venv \
		openssl \
		curl \
		wget

# clean up
RUN apt-get clean && \
	apt-get autoremove -y && \
	apt-get autoclean -y

################################ Install LaTex #################################

RUN mkdir -p /opt/texlive
COPY texlive.profile /opt/texlive/texlive.profile

RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xvzf install-tl-unx.tar.gz
RUN cd install-tl-*/ && \
	./install-tl -profile /opt/texlive/texlive.profile
RUN rm -rf install-tl-* install-tl-unx.tar.gz

RUN echo 'export PATH=/opt/texlive/bin/$(uname -m)-linux:$PATH' >> /etc/profile.d/50-texlive.sh
RUN chmod 755 /etc/profile.d/50-texlive.sh

RUN echo '# add texlive to PATH'                                >> /etc/bash.bashrc
RUN echo 'export PATH=/opt/texlive/bin/$(uname -m)-linux:$PATH' >> /etc/bash.bashrc
