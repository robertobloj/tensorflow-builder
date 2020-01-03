FROM robloj/tensorflow-sources:r1.14
MAINTAINER Robert Obloj <robloj@gmail.com>

# variables for configure.py script
ARG TF_NEED_JEMALLOC=1
ARG TF_NEED_GCP=1
ARG TF_NEED_HDFS=1
ARG TF_NEED_AWS=1
ARG TF_NEED_S3=1
ARG TF_NEED_ROCM=0
ARG TF_NEED_KAFKA=1
ARG TF_ENABLE_XLA=0
ARG TF_NEED_GDR=0
ARG TF_NEED_VERBS=0
ARG TF_NEED_MPI=0
ARG TF_NEED_OPENCL_SYCL=0
ARG TF_NEED_CUDA=0
ARG TF_DOWNLOAD_CLANG=0
ARG TF_SET_ANDROID_WORKSPACE=0

ENV CC_OPT_FLAGS "-mtune=generic"
ENV PYTHON_BIN_PATH /usr/bin/python
ENV PYTHON_LIB_PATH /usr/local/lib/python3.7/site-packages

# 1. For newer gcc >= 5.0.0 we require ABI switch set to 0
ENV USE_ABI_SWITCH="5.0.0"
ENV CURRENT_GCC_VER="$(gcc -dumpversion)"
RUN if [ "$(printf '%s\n' "$USE_ABI_SWITCH" "$CURRENT_GCC_VER" | sort -V | head -n1)" = "$USE_ABI_SWITCH" ]; then \
    export abi_switch="--cxxopt='-D_GLIBCXX_USE_CXX11_ABI=0'"; fi

# 2. We make python3 default distribution, we also install required packages
RUN ln -fs /usr/local/bin/python3.7 /usr/bin/python
RUN python -m pip install --upgrade pip && \
    python -m pip install six numpy wheel setuptools h5py mock future>=0.17.1
RUN python -m pip install keras_applications==1.0.6 --no-deps && \
    python -m pip install keras_preprocessing==1.0.5 --no-deps

# 3. We configure tensorflow
RUN python ./configure.py 2>&1

# 4. We compile tensorflow and do "sleep infinity", because you want to copy
# tensorflow wheel into local filesystem
CMD bazel build --config=opt \
      $abi_switch //tensorflow/tools/pip_package:build_pip_package 2>&1 && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg; sleep infinity
