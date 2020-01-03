FROM robloj/tensorflow-bazel:r1.14
MAINTAINER Robert Obloj <robloj@gmail.com>

ARG TF_VERSION='r1.14'

ENV tensorflow_name tensorflow-$TF_VERSION
ENV tensorflow_zip https://github.com/tensorflow/tensorflow/archive/$TF_VERSION.zip
ENV tensorflow_zip_dest $tensorflow_name.zip

RUN wget -c $tensorflow_zip -O /tmp/$tensorflow_zip_dest 2>&1 && \
    unzip /tmp/$tensorflow_zip_dest -d / && \
    rm /tmp/$tensorflow_zip_dest

WORKDIR /$tensorflow_name
CMD /bin/bash
