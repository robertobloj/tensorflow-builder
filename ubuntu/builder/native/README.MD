# TensorFlow native binary

Image contains [tensorflow](https://www.tensorflow.org) compiled
from sources with *native mode*. Read more about *native mode* [here](https://gcc.gnu.org/onlinedocs/gcc-4.5.3/gcc/i386-and-x86_002d64-Options.html).

__IMPORTANT:__ Native architecture means image contains native tensorflow for machine,
where image was built. So you can use tensorflow from this image, but your
architecture can be completely different. Be aware of that!

## How to compile my own tensorflow native package?

If you want to build tensorflow with your cpu architecture,
you have to run following command:

```
docker build -t my-tensorflow-native .
```

Notice that compilation process is very long and can take even __few hours__!

When compilation will finish, you have to use image to copy compiled tensorflow
into your local filesystem.

## How to use image?

You have to do three steps:

### 1. Run image

```
docker run --name tf2copy -d -it robloj/ubuntu-tensorflow-native
```

Notice, we run named container with name *tf2copy*.

### 2. Find container id

```
docker ps
```

Example result:

```
CONTAINER ID   IMAGE                    COMMAND      CREATED        STATUS       PORTS  NAMES
b4fef7c3adfd   ubuntu-tensorflow-native "/bin/bash"  5 seconds ago  Up 4 seconds        tf2copy
```

Your container id is *b4fef7c3adfd*

### 3. Copy tensorflow wheel into your local filesystem

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
