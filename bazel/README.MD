# TensorFlow Bazel

Image installs and configures [bazel build tool](https://docs.bazel.build/)
for compiling [tensorflow](https://www.tensorflow.org) directly from sources.

Additionally image contains [python3.7](https://www.python.org/) which is required for [tensorflow](https://www.tensorflow.org).

Check more documentation on [github](https://github.com/robertobloj/tensorflow-builder).

## How to use image?

By default you don't need to do anything except run image:

```
docker run -it robloj/tensorflow-bazel
```

When image is downloaded, you can check if bazel exists:

```
root@39f0849fe655:/# bazel version
Extracting Bazel installation...
WARNING: --batch mode is deprecated. Please instead explicitly shut down your Bazel server using the command "bazel shutdown".
Build label: 0.26.1
Build target: bazel-out/k8-opt/bin/src/main/java/com/google/devtools/build/lib/bazel/BazelServer_deploy.jar
Build time: Thu Jun 6 11:05:05 2019 (1559819105)
Build timestamp: 1559819105
Build timestamp as int: 1559819105
```

That's all. Now you can use bazel.

## How to build my own bazel image?

If you want to build your own bazel image, you have to provide bazel and gcc
versions. For example:

```
docker build --build-arg BAZEL_VER=0.26.1 --build-arg PYTHON_VER=3.7.6 -t tensorflow-bazel .
```

Where:

- BAZEL_VER - [bazel](https://docs.bazel.build/) version you want to use
