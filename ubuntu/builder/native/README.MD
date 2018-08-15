# TensorFlow native binary

Image contains [tensorflow](https://www.tensorflow.org) compiled
from sources with native mode. Read more about native mode [here](https://gcc.gnu.org/onlinedocs/gcc-4.5.3/gcc/i386-and-x86_002d64-Options.html).

## How to use image?

You have to do three steps:

### 1. Run image

```
docker run --name tf2copy -d -it robloj/ubuntu-tensorflow-native
```

Notice, we run named container with name *tf2copy*

### 2. Find container id

```
docker ps
```

Example result:

```
c:\data\documents\robert\tensorflowgit\tensorflow-builder>docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS            PORTS          NAMES
b4fef7c3adfd        centos              "/bin/bash"         5 seconds ago        Up 4 seconds                            tf2copy
```

Your container id is *b4fef7c3adfd*

### 3. Copy tensorflow wheel into your local filesystem

```
docker cp $CONTAINER_ID:/tmp/tensorflow_pkg $BUILD_DIR
```

Where:

- $CONTAINER_ID - id copied from step 2
- $BUILD_DIR - destination directory for compiled tensorflow

## How to build my own tensorflow sources image?

If you want to build tensorflow with your cpu architecture,
you have to run following command:

```
docker build -t my-tensorflow-native .
```

Notice that compilation process is long and can take even few hours!
