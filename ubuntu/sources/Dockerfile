# This dockerfile allows to build tensorflow from sources
#
# FAQ:
#  - I want to build image
#       docker build --build-arg tensorflow_ver=r1.9 -t tensorflow-sources .
#  - I want to run image with mapped local disk
#       docker run -it tensorflow-sources

FROM tensorflow-bazel
MAINTAINER Robert Obloj <robloj@gmail.com>

ARG TF_VERSION='r1.9'

ENV tensorflow_name tensorflow-$TF_VERSION
ENV tensorflow_zip https://github.com/tensorflow/tensorflow/archive/$TF_VERSION.zip
ENV tensorflow_zip_dest $tensorflow_name.zip

# 1. install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    python3-numpy \
    python3-dev \
    python3-pip \
    python3-wheel

# 2. download tensorflow and install required pip packages
RUN wget -c $tensorflow_zip -O /tmp/$tensorflow_zip_dest 2>&1 && \
    unzip /tmp/$tensorflow_zip_dest -d / && \
    rm /tmp/$tensorflow_zip_dest && \
    python -m pip install six numpy wheel setuptools

# 3. run container
WORKDIR /$tensorflow_name
CMD /bin/bash
