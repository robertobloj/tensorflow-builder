# centos 7
FROM centos:7
MAINTAINER Robert Obloj <robloj@gmail.com>

ARG BAZEL_VER=0.24.1
ARG PYTHON_VER=3.7.6
ARG GIT_VERSION=2.18.0

ENV bazel_installer https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VER/bazel-$BAZEL_VER-installer-linux-x86_64.sh
ENV bazel_installer_file /tmp/bazel_$BAZEL_VER.sh

ENV python_dir /Python-$PYTHON_VER
ENV python_installer https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz
ENV python_installer_file $python_dir.tgz

ENV git_installer https://github.com/git/git/archive/v$GIT_VERSION.tar.gz
ENV git_installer_file git.tar.gz

ENV devtools_installer http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo
ENV devtools_installer_file /etc/yum.repos.d/slc6-devtoolset.repo
ENV ius_rpm https://centos7.iuscommunity.org/ius-release.rpm


# 1. install required packages
RUN echo timeout=200 >> /etc/yum.conf
RUN yum update -y && yum install -y zip \
    unzip \
    wget \
    yum-utils \
	which \
	groupinstall \
    development \
    centos-release-scl \
	zlib-devel \
	bzip2-devel \
	openssl-devel \
	ncurses-devel \
	sqlite-devel \
	readline-devel \
	tk-devel \
	gdbm-devel \
	xz-devel \
	libffi-devel \
    patch 2>&1

# 2. install gcc 4.8.5
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum install -y devtoolset-7 gcc-c++ 2>&1 && \
    scl enable devtoolset-7 bash
	
	
# 3. we need to compile git from sources, because tensorflow requires `-C` option which is not available in git provided by yum for centos7
RUN yum groupinstall -y "Development Tools" && \
	yum install -y gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel curl-devel && \
	wget -c $git_installer -O $git_installer_file 2>&1 && \
	tar -zxf $git_installer_file && \
	cd git-$GIT_VERSION && \
	make configure && \
	./configure --prefix=/usr/local && \
	make install && \
	rm -f $git_installer_file

	
# 4. install bazel
RUN wget -c $bazel_installer -O $bazel_installer_file 2>&1 && \
    chmod +x $bazel_installer_file && \
    $bazel_installer_file

# 5 . install python3.7
RUN wget -c $python_installer -O $python_installer_file 2>&1 && \
	tar xzf $python_installer_file && \
	rm -f $python_installer_file && \
	cd $python_dir && \
	./configure --enable-optimizations && \
	make altinstall && \
	python3.7 -V && \
	bazel version

CMD /bin/bash
