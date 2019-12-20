# centos 8
FROM centos
MAINTAINER Robert Obloj <robloj@gmail.com>

ARG BAZEL_VER=0.26.1
ARG PYTHON_VER=3.7.6

ENV bazel_installer https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VER/bazel-$BAZEL_VER-installer-linux-x86_64.sh
ENV bazel_installer_file /tmp/bazel_$BAZEL_VER.sh

ENV python_dir /Python-$PYTHON_VER
ENV python_installer https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz
ENV python_installer_file $python_dir.tgz


# 1. install required packages
RUN echo timeout=200 >> /etc/yum.conf
RUN yum update -y && yum install -y zip \
    unzip \
    wget \
    yum-utils \
	which \
	zlib-devel \
    patch 2>&1

RUN dnf group -y install "Development Tools" && \
	dnf -y install java-11-openjdk-devel

# 2. install gcc 4.8.5 TODO DOWNGRADE
#RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
#    yum install -y devtoolset-8 gcc-c++ 2>&1 && \
#    scl enable devtoolset-8 bash

# 3. install bazel
RUN wget -c $bazel_installer -O $bazel_installer_file 2>&1 && \
    chmod +x $bazel_installer_file && \
    $bazel_installer_file

# 4. install python3.7
RUN wget -c $python_installer -O $python_installer_file 2>&1 && \
	tar xzf $python_installer_file && \
	rm -f $python_installer_file && \
	cd $python_dir && \
	./configure --enable-optimizations && \
	make altinstall && \
	python3.7 -V && \
	bazel version

CMD /bin/bash
