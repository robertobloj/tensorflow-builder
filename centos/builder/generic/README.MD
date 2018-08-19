# TensorFlow generic binary

Image allows to compile [tensorflow](https://www.tensorflow.org)
from sources with *generic mode*. Read more about *generic mode* [here](https://gcc.gnu.org/onlinedocs/gcc-4.5.3/gcc/i386-and-x86_002d64-Options.html).

__IMPORTANT:__ Generic image is prepared for producing code optimized
for the most common IA32/AMD64/EM64T processors.
If you know the CPU on which your code will run, then you should use
the corresponding -mtune option instead of -mtune=generic.
But, if you do not know exactly what CPU users of your application
will have, then you should use this option.

Check more documentation on [github](https://github.com/robertobloj/tensorflow-builder).

## How to compile tensorflow with generic mode?

Notice that compilation process is very long and can take even __few hours__!

When compilation will finish, you have to use image to copy compiled tensorflow
into your local filesystem.


For compilation process you have to do steps:

### 1. Run image

```
docker run --name tf2copy -it robloj/centos-tensorflow-generic
```


Notice, we run named container with name *tf2copy*.

Wait until compilation process is done. You should see logs similar to:


```
...

bazel-out/k8-opt/genfiles/external/protobuf_archive/src: warning: directory does not exist.
Target //tensorflow/tools/pip_package:build_pip_package up-to-date:
  bazel-bin/tensorflow/tools/pip_package/build_pip_package
INFO: Elapsed time: 9026.270s, Critical Path: 95.38s
INFO: 6801 processes: 6801 local.
INFO: Build completed successfully, 7502 total actions
Sun Aug 19 09:23:50 UTC 2018 : === Preparing sources in dir: /tmp/tmp.jbIBSPuSwb
/tensorflow-r1.10 /tensorflow-r1.10
/tensorflow-r1.10
Sun Aug 19 09:24:02 UTC 2018 : === Building wheel
warning: no files found matching '*.dll' under directory '*'
warning: no files found matching '*.lib' under directory '*'
warning: no files found matching '*.h' under directory 'tensorflow/include/tensorflow'
warning: no files found matching '*' under directory 'tensorflow/include/Eigen'
warning: no files found matching '*.h' under directory 'tensorflow/include/google'
warning: no files found matching '*' under directory 'tensorflow/include/third_party'
warning: no files found matching '*' under directory 'tensorflow/include/unsupported'
Sun Aug 19 09:24:21 UTC 2018 : === Output wheel file is in: /tmp/tensorflow_pkg
```

### 2. Find container id

Open new terminal and type:

```
docker ps

```


Example result:

```
CONTAINER ID   IMAGE                     COMMAND       CREATED        STATUS       PORTS  NAMES
b4fef7c3adfd   centos-tensorflow-generic "/bin/sh..."  5 seconds ago  Up 4 seconds        tf2copy

```


Your container id is *b4fef7c3adfd*

### 3. Copy tensorflow wheel into your local filesystem

Finally you can copy tensorflow wheel:

```

CONTAINER_ID=b4fef7c3adfd
DEST_DIR=/tmp/output

docker cp $CONTAINER_ID:/tmp/tensorflow_pkg $DEST_DIR

```


Where:

- $CONTAINER_ID - id copied from step 2
- $DEST_DIR - destination directory for compiled tensorflow

As result you should have compiled tensorflow in your destination dir:

```
ls $DEST_DIR

tensorflow-1.10.0-cp36-cp36m-linux_x86_64.whl
```


Congratulation! You have wheel package and you can easily install it via *pip*.
