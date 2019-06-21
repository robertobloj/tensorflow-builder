FROM centos
MAINTAINER Robert Obloj <robloj@gmail.com>

ARG BAZEL_VER=0.19.2

ENV bazel_installer https://copr.fedorainfracloud.org/coprs/vbatts/bazel/repo/epel-7/vbatts-bazel-epel-7.repo
ENV bazel_installer_file /etc/yum.repos.d/vbatts-bazel-epel-7.repo
ENV devtools_installer http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo
ENV devtools_installer_file /etc/yum.repos.d/slc6-devtoolset.repo
ENV ius_rpm https://centos7.iuscommunity.org/ius-release.rpm

# 1. install required packages
RUN echo timeout=200 >> /etc/yum.conf
RUN yum update -y && yum install -y zip \
    unzip \
    wget \
    yum-utils \
    groupinstall \
    development \
    centos-release-scl \
    patch 2>&1

# 2. install gcc 4.8.5
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum install -y devtoolset-7 gcc-c++ 2>&1 && \
    scl enable devtoolset-7 bash

# 3. install bazel
RUN wget -c $bazel_installer -O $bazel_installer_file 2>&1 && \
    yum install -y bazel 2>&1

# 4. install python3.6
RUN yum install -y $ius_rpm 2>&1 && \
    yum install -y python36u \
        python36u-pip \
        python36u-devel \
        python3-dev \
        python3-pip \
        python-wheel 2>&1 && \
        bazel version

CMD /bin/bash
