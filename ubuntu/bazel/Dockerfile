# This dockerfile allows to build image with bazel.
# Image is prepared by following instructions from:
# https://docs.bazel.build/versions/master/install-ubuntu.html#install-with-installer-ubuntu
#
# FAQ:
#  - I want to build image
#       docker build --build-arg BAZEL_VER=0.15.1 -t tensorflow-bazel .
#
#  - I want to run image
#       docker run -it tensorflow-bazel

FROM ubuntu:18.04
MAINTAINER Robert Obloj <robloj@gmail.com>

# 0. consts for image
ARG BAZEL_VER=0.15.1
ARG GCC_VER=4.8

ENV bazel_installer https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VER/bazel-$BAZEL_VER-installer-linux-x86_64.sh
ENV bazel_installer_file /tmp/bazel.sh

# 1. install required packages for bazel
RUN apt-get update && apt-get install -y pkg-config \
    apt-utils \
    zip \
    zlib1g-dev \
    unzip \
    python3 \
    software-properties-common \
    wget

# 2. install specified gcc for compilation process and make it a default gcc
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get install -y \
        gcc-$GCC_VER \
        g++-$GCC_VER && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$GCC_VER 20 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-$GCC_VER 20

# 3. install bazel, configure python
RUN wget -c $bazel_installer -O $bazel_installer_file 2>&1 && \
    chmod +x $bazel_installer_file && $bazel_installer_file && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    bazel version && \
    rm $bazel_installer_file

CMD /bin/bash
