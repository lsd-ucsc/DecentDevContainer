# Copyright (c) 2024 Haofan Zheng
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

FROM ghcr.io/lsd-ucsc/decent-latex-base:c2c70fc


ENV DEBIAN_FRONTEND=noninteractive


############################### Install packages ###############################

RUN apt-get update -y && \
	apt-get install -y \
		libgtk-3-0t64 \
		libnotify4 \
		libnss3 \
		libxss1 \
		libxtst6 \
		xdg-utils \
		libatspi2.0-0t64 \
		libsecret-1-0 \
		libasound2t64 \
		xvfb \
		git \
		sudo

# clean up
RUN apt-get clean && \
	apt-get autoremove -y && \
	apt-get autoclean -y


################################ Install DrawIO ################################

COPY install-drawio.sh install-drawio.sh
RUN chmod 755 install-drawio.sh
RUN ./install-drawio.sh
RUN rm install-drawio.sh

COPY drawio-cli /usr/bin/drawio-cli
RUN chmod 755 /usr/bin/drawio-cli

################################ Install LaTex #################################

