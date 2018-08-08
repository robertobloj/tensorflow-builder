# This dockerfile allows to build tensorflow from sources
#
# FAQ:
#  - I want to build image
#       docker build -t tensorflow-builder-generic .
#  - I want to run image
#       docker run -it tensorflow-builder-generic

FROM tensorflow-sources
MAINTAINER Robert Obloj <robloj@gmail.com>

# variables from .env
ARG TF_NEED_JEMALLOC
ARG TF_NEED_GCP
ARG TF_NEED_HDFS
ARG TF_NEED_S3
ARG TF_NEED_KAFKA
ARG TF_ENABLE_XLA
ARG TF_NEED_GDR
ARG TF_NEED_VERBS
ARG TF_NEED_MPI
ARG TF_NEED_OPENCL_SYCL
ARG TF_NEED_CUDA
ARG TF_DOWNLOAD_CLANG
ARG TF_SET_ANDROID_WORKSPACE

# we ignore on purpose CC_OPT_FLAGS value in .env file,
# we want to build generic architecture here
ENV CC_OPT_FLAGS "-mtune=generic"
ENV PYTHON_BIN_PATH /usr/bin/python
ENV PYTHON_LIB_PATH /usr/local/lib/python3.6/dist-packages

# 1. For newer gcc >= 5.0.0 we require ABI switch set to 0
ENV USE_ABI_SWITCH="5.0.0"
ENV CURRENT_GCC_VER="$(gcc -dumpversion)"
RUN if [ "$(printf '%s\n' "$USE_ABI_SWITCH" "$CURRENT_GCC_VER" | sort -V | head -n1)" = "$USE_ABI_SWITCH" ]; then \
    export abi_switch="--cxxopt='-D_GLIBCXX_USE_CXX11_ABI=0'"; fi

# 2. Finally we configure and compile tensorflow
RUN python ./configure.py && \
    bazel build \
        --config=opt \
        \
        # when you build with CC_OPT_FLAGS=-mtune=generic, you can enable or disable gcc options
        # enablers
        --copt=-mmmx \
        --copt=-msse \
        --copt=-msse2 \
        # --copt=-msse3 \
        # --copt=-mssse3 \
        # --copt=-msse4.1 \
        # --copt=-msse4.2 \
        # --copt=-msse4 \
        # --copt=-mavx \
        # --copt=-maes \
        # --copt=-mpclmul \
        # --copt=-msse4a \
        # --copt=-mfma4 \
        # --copt=-mxop \
        # --copt=-mlwp \
        # --copt=-m3dnow \
        # --copt=-mpopcnt \
        # --copt=-mabm \
        \
        # disablers
        # --copt=-mno-mmx \
        # --copt=-mno-sse \
        # --copt=-mno-sse2 \
        --copt=-mno-sse3 \
        --copt=-mno-ssse3 \
        --copt=-mno-sse4.1 \
        --copt=-mno-sse4.2 \
        --copt=-mno-sse4 \
        --copt=-mno-avx \
        --copt=-mno-aes \
        --copt=-mno-pclmul \
        --copt=-mno-sse4a \
        --copt=-mno-fma4 \
        --copt=-mno-xop \
        --copt=-mno-lwp \
        --copt=-mno-3dnow \
        --copt=-mno-popcnt \
        --copt=-mno-abm \
        \
        $abi_switch //tensorflow/tools/pip_package:build_pip_package 2>&1 && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
CMD /bin/bash
