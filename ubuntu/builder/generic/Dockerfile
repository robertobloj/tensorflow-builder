# This dockerfile allows to build tensorflow from sources
#
# FAQ:
#  - I want to build image
#       docker build -t ubuntu-tensorflow-generic .
#  - I want to run image
#       docker run -it ubuntu-tensorflow-generic

FROM robloj/ubuntu-tensorflow-sources
MAINTAINER Robert Obloj <robloj@gmail.com>

# variables for configure.py script
ARG TF_NEED_JEMALLOC=1
ARG TF_NEED_GCP=1
ARG TF_NEED_HDFS=1
ARG TF_NEED_AWS=1
ARG TF_NEED_S3=1
ARG TF_NEED_KAFKA=1
ARG TF_ENABLE_XLA=0
ARG TF_NEED_GDR=0
ARG TF_NEED_VERBS=0
ARG TF_NEED_MPI=0
ARG TF_NEED_OPENCL_SYCL=0
ARG TF_NEED_CUDA=0
ARG TF_DOWNLOAD_CLANG=0
ARG TF_SET_ANDROID_WORKSPACE=0

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
    # somehow we still have -march=native in host_opts, we remove it
    sed -i '/build:opt --host_copt=-march=native/d' ./.tf_configure.bazelrc && \
    bazel build \
        --config=opt \
        \
        # when you build with CC_OPT_FLAGS=-mtune=generic, you can enable or disable gcc options
        # enablers
        # --copt=-mmmx \
        # --copt=-msse \
        # --copt=-msse2 \
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
        # --copt=-mno-sse3 \
        # --copt=-mno-ssse3 \
        # --copt=-mno-sse4.1 \
        # --copt=-mno-sse4.2 \
        # --copt=-mno-sse4 \
        # --copt=-mno-avx \
        # --copt=-mno-aes \
        # --copt=-mno-pclmul \
        # --copt=-mno-sse4a \
        # --copt=-mno-fma4 \
        # --copt=-mno-xop \
        # --copt=-mno-lwp \
        # --copt=-mno-3dnow \
        # --copt=-mno-popcnt \
        # --copt=-mno-abm \
        \
        $abi_switch //tensorflow/tools/pip_package:build_pip_package 2>&1 && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
CMD /bin/bash
