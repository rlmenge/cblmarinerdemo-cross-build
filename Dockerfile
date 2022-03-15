FROM arm64v8/ubuntu

# apt-get update and apt-get install should run together to avoid caching issues
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# DEBIAN_FRONTEND=noninteractive to set to default values (avoids setting timezone)

COPY configure_buildenv.sh /

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
		git \
		sudo \
		software-properties-common
RUN sudo add-apt-repository ppa:longsleep/golang-backports
RUN apt-get update && apt -y install \ 
		make \
		tar \
		wget \
		curl \
		rpm \
		qemu-utils \
		golang-1.13-go \
		genisoimage \
        pigz \
		cpio \
		python2 \
		python3-distutils 

RUN sudo ln -vs /usr/lib/go-1.13/bin/go /usr/bin/go