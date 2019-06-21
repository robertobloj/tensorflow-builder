# TensorFlow Bazel

Image installs and configures [bazel build tool](https://docs.bazel.build/)
for compiling [tensorflow](https://www.tensorflow.org) directly from sources.

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
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.google.protobuf.UnsafeUtil (file:/root/.cache/bazel/_bazel_root/install/cca766fceacebfea470f866e003d5e57/_embedded_binaries/A-s
erver.jar) to field java.nio.Buffer.address
WARNING: Please consider reporting this to the maintainers of com.google.protobuf.UnsafeUtil
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
WARNING: --batch mode is deprecated. Please instead explicitly shut down your Bazel server using the command "bazel shutdown".
Build label: 0.27.0
Build target: bazel-out/k8-opt/bin/src/main/java/com/google/devtools/build/lib/bazel/BazelServer_deploy.jar
Build time: Mon Jun 17 00:00:00 2019 (1560729600)
Build timestamp: 1560729600
Build timestamp as int: 1560729600
```

That's all. Now you can use bazel.

## How to build my own bazel image?

If you want to build your own bazel image, you have to provide bazel and gcc
versions. For example:

```
docker build --build-arg BAZEL_VER=0.15.1 -t my-tensorflow-bazel .
```

Where:

- BAZEL_VER - [bazel](https://docs.bazel.build/) version you want to use
