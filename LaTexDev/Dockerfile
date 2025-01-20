# Copyright (c) 2024 Haofan Zheng
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

FROM ghcr.io/lsd-ucsc/decent-latex:d873179


################################ Setup Root User ###############################

RUN cp /etc/skel/.bashrc      /root/.bashrc && \
	cp /etc/skel/.profile     /root/.profile && \
	cp /etc/skel/.bash_logout /root/.bash_logout

################################ Setup Dev User ################################

RUN deluser --remove-home ubuntu

ARG DEV_USERNAME=vscode
ARG DEV_USERID=1000
ARG DEV_GROUPNAME=${DEV_USERNAME}
ARG DEV_GROUPID=${DEV_USERID}

RUN mkdir -p /home/${DEV_USERNAME}/workspace && \
	cp /etc/skel/.bashrc      /home/${DEV_USERNAME}/.bashrc && \
	cp /etc/skel/.profile     /home/${DEV_USERNAME}/.profile && \
	cp /etc/skel/.bash_logout /home/${DEV_USERNAME}/.bash_logout

# backup the original /etc/passwd, /etc/group, and /etc/shadow
RUN cp /etc/passwd /etc/passwd.decent.bak && \
	cp /etc/group /etc/group.decent.bak && \
	cp /etc/shadow /etc/shadow.decent.bak

# Create the user
RUN groupadd --gid $DEV_GROUPID $DEV_GROUPNAME \
	&& useradd \
		--shell /bin/bash \
		--home-dir /home/${DEV_USERNAME} \
		--no-create-home \
		--uid $DEV_USERID \
		--gid $DEV_GROUPID \
		$DEV_USERNAME \
	&& echo $DEV_USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$DEV_USERNAME \
	&& chmod 0440 /etc/sudoers.d/$DEV_USERNAME \
	&& chown -R $DEV_USERNAME:$DEV_GROUPNAME /home/${DEV_USERNAME}


USER $DEV_USERNAME
