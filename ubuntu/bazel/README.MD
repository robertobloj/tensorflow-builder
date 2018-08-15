# TensorFlow Bazel

Image installs and configures [bazel build tool](https://docs.bazel.build/) for compiling [tensorflow](https://www.tensorflow.org) directly from sources.

Image is prepared by instructions available on [bazel documentation web page](https://docs.bazel.build/versions/master/install-ubuntu.html#install-with-installer-ubuntu).

Check more documentation on [github](https://github.com/robertobloj/tensorflow-builder).

## How to use image?

By default you don't need to do anything except run image:

```
docker run -it robloj/ubuntu-tensorflow-bazel
```

When image is downloaded, you can check if bazel exists:

```
root@39f0849fe655:/# bazel version

WARNING: --batch mode is deprecated. Please instead explicitly shut down
your Bazel server using the command "bazel shutdown".
Build label: 0.15.1
Build target: bazel-out/k8-opt/bin/...build/lib/bazel/BazelServer_deploy.jar
Build time: Mon Jul 16 14:16:24 2018 (1531750584)
Build timestamp: 1531750584
Build timestamp as int: 1531750584
```


That's all. Now you can use bazel.

## How to build my own bazel image?

If you want to build your own bazel image, you have to provide bazel and gcc
versions. For example:

```
docker build --build-arg BAZEL_VER=0.15.1 --build-arg GCC_VER=4.8 -t my-tensorflow-bazel .
```


Where:

- BAZEL_VER - [bazel](https://docs.bazel.build/) version you want to use
- GCC_VER - [gcc](https://gcc.gnu.org/) version you want to use
