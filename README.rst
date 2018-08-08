===============================
Install TensorFlow from Sources
===============================

Tensorflow can be compiled directly from sources. Compiling from sources needs some time and knowledge,
especially because if you need to compile tensorflow, you want to choose some extra flags for your requirements.
These flags are very poorly documented on `install from sources`_ article.

We prepared few docker images and docker-compose file which allows to compile tensorflow from sources for unix OS
with a little knowledge:

1. bazel - image with bazel_ which is an open-source build and test tool similar to Make, Maven, and Gradle.
2. sources - image with tensorflow_ sources downloaded from github_. Image depends on bazel image.
3. builder - image allows to build tensorflow from sources. Image depends on sources images.

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

Now you can check, what instructions you need to enable/disable in compiling process.
Please also check `gcc compilation flags`_ and choose proper compilation options for gcc_.

Let assume our server supports *MMX*, *SSE* and *SSE2* instructions. Given this we choose *pentium* as cpu type.

Next step is setup our compilation process. Please edit *.env* file and change *CC_OPT_FLAGS* flag into:

.. code-block:: bash

    CC_OPT_FLAGS=-mtune=pentium4

You can also change other values depends on your requirements. There are default values for tensorflow compiling
process, so in general you don't need to change anything except *CC_OPT_FLAGS*.

Examples
-----------------------------------------

1. We want to build tensorflow with native architecture (building process uses compiling machine CPU for determining
the processor type).

We can edit *.env* file and choose:

.. code-block:: bash

    CC_OPT_FLAGS=-mtune=native

2. We want to build tensorflow with Kafka support, but we don't need support for S3:

We can edit *.env* file and setup:

.. code-block:: bash

    # Do you wish to build TensorFlow with Amazon S3 File System support? [Y/n]
    TF_NEED_S3=0

    # Do you wish to build TensorFlow with Apache Kafka Platform support? [Y/n]
    TF_NEED_KAFKA=1

3. We want to build tensorflow for the most common IA32/AMD64/EM64T processors:

We can edit *.env* file and choose:

.. code-block:: bash

    CC_OPT_FLAGS=-mtune=generic

4. We want to build tensorflow for the most common IA32/AMD64/EM64T processors, but also want to enable/disable some specified instructions:

We can edit *.env* file and setup *CC_OPT_FLAGS*:

.. code-block:: bash

    CC_OPT_FLAGS=-mtune=generic

Additionally you can setup enablers and disablers for compilation process. For example we want
to enable only MMX, SSE and SSE2 instructions. We also want to be sure AVX instructions are disabled.

Again open *.env* file, edit *CC_OPT_ENABLE_FLAGS* and *CC_OPT_DISABLE_FLAGS* flags and define enablers and or disablers:

.. code-block:: bash

    CC_OPT_ENABLE_FLAGS=--copt=-mmmx --copt=-msse --copt=-msse2
    CC_OPT_DISABLE_FLAGS=--copt=-mno-avx --copt=-mno-avx2


How to compile tensorflow from sources?
-----------------------------------------

When we have configured variables, we can build tensorflow from sources by running following command:

.. code-block:: bash

    run.bat

Script builds:

- bazel image - image downloads bazel, installs requirements, prepares for work.
- sources image - image downloads tensorflow sources, extracts it.
- builder image - images setup compiling process, compiles sources and package it

When images are ready to work, script also starts builder container and copies compiled tensorflow
into local filesystem. Finally script stops builder container.

.. _install from sources: https://www.tensorflow.org/install/install_sources
.. _bazel: https://docs.bazel.build/
.. _tensorflow: https://www.tensorflow.org
.. _github: https://github.com/tensorflow/tensorflow
.. _coreinfo: https://docs.microsoft.com/pl-pl/sysinternals/downloads/coreinfo
.. _page: https://docs.microsoft.com/en-us/windows-server/get-started/system-requirements
.. _gcc compilation flags: https://gcc.gnu.org/onlinedocs/gcc-4.5.3/gcc/i386-and-x86_002d64-Options.html
.. _gcc: https://gcc.gnu.org/