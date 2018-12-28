===============================
TensorFlow builder
===============================

Tensorflow can be compiled directly from sources. Compiling from sources needs some time and knowledge,
especially because if you need to compile tensorflow, in general you want to choose some extra
flags for your environment.
These flags are very poorly documented on `install from sources`_ article.

We prepared few docker images which allows to compile tensorflow from sources for unix OS
with a little knowledge:

1. bazel - image with bazel_ which is an open-source build and test tool similar to Make, Maven, and Gradle.
2. sources - image with tensorflow_ sources downloaded from github_. Image depends on bazel image.
3. builder - images allow to build tensorflow from sources. Images depend on sources images.

**IMPORTANT:** These images don't support GPU compilation for now.

What tensorflow version do I need?
----------------------------------

If you are not sure, what tensorflow you need, you should check what CPU instructions your server supports.

.. code-block:: bash

    cat /proc/cpuinfo | grep flags

Example output:

.. code-block:: bash

    flags:  fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 \
            ss syscall nx lm constant_tsc rep_good nopl eagerfpu pni cx16 hypervisor lahf_lm

Now you can see, what instructions you need to enable/disable in compiling process.

For further investigation please also check `gcc compilation flags`_
and choose proper compilation options for chosen gcc_.

What builder image do I need?
----------------------------------

We provided following images for compiling process:

- *builder/core2* - image compiles tensorflow optimized for Intel Core2 CPU with 64-bit extensions, MMX, SSE, SSE2, SSE3 and SSSE3 instruction set support.
- *builder/generic* - image compiles tensorflow optimized for the most common *IA32/AMD64/EM64T* processors.
- *builder/native* - image compiles tensorflow optimized for the local machine under the constraints of the selected instruction set
- *builder/pentium4* - image compiles tensorflow optimized for Intel Pentium4 CPU with *MMX*, *SSE* and *SSE2* instruction set support.

You can also easily build your own Dockerfile based on examples above.

How to use it?
-----------------------------------

The simplest way is to run chosen docker image. Depends what you have chosen,
run ONLY one of following commands:

.. code-block:: bash

    docker run --name tf-core2 -it robloj/tensorflow-core2
    docker run --name tf-generic -it robloj/tensorflow-generic
    docker run --name tf-native -it robloj/tensorflow-native
    docker run --name tf-pentium4 -it robloj/tensorflow-pentium4

This command starts compilation process which takes some time depends
on your environment.

**IMPORTANT** - Notice that compilation process is very long and can take even **few hours**!

Wait until compilation process is done. You should see logs similar to:

.. code-block:: bash

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

Find container id:

.. code-block:: bash

  docker ps

Example result:

.. code-block:: bash

  CONTAINER ID   IMAGE               COMMAND       CREATED        STATUS       PORTS  NAMES
  b4fef7c3adfd   tensorflow-generic  "/bin/sh..."  5 seconds ago  Up 4 seconds        tf-generic

Your container id is *b4fef7c3adfd*

Finally you can copy tensorflow wheel into your local filesystem:

.. code-block:: bash

  CONTAINER_ID=b4fef7c3adfd
  DEST_DIR=/tmp/output

  docker cp $CONTAINER_ID:/tmp/tensorflow_pkg $DEST_DIR

Where:

- $CONTAINER_ID - container id found by command above
- $DEST_DIR - destination directory for compiled tensorflow

As result you should have compiled tensorflow in your destination dir:

.. code-block:: bash

  ls $DEST_DIR

  tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl

Congratulation! You have wheel package and you can easily install it via *pip*:

.. code-block:: bash

  cd $DEST_DIR
  python -m pip install tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl

The end!


.. _install from sources: https://www.tensorflow.org/install/install_sources
.. _bazel: https://docs.bazel.build/
.. _tensorflow: https://www.tensorflow.org
.. _github: https://github.com/tensorflow/tensorflow
.. _coreinfo: https://docs.microsoft.com/pl-pl/sysinternals/downloads/coreinfo
.. _page: https://docs.microsoft.com/en-us/windows-server/get-started/system-requirements
.. _gcc compilation flags: https://gcc.gnu.org/onlinedocs/gcc-4.5.3/gcc/i386-and-x86_002d64-Options.html
.. _gcc: https://gcc.gnu.org/
