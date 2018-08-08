===============================
TensorFlow builder
===============================

Tensorflow can be compiled directly from sources. Compiling from sources needs some time and knowledge,
especially because if you need to compile tensorflow, in general you want to choose some extra flags for your environment.
These flags are very poorly documented on `install from sources`_ article.

We prepared few docker images and docker-compose file which allows to compile tensorflow from sources for unix OS
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

What builder image do I need?
----------------------------------

We provided two images for compiling process:

- builder/generic - image produces code optimized for the most common *IA32/AMD64/EM64T* processors.
- builder/arch - image allows you to decide what architecture you need

If you want to build tensorflow optimized for most common CPUs,
choose generic version. For this option you can go directly to `Generic CPU`_.

If you checked `What tensorflow version do I need?`_ and you have chosen
proper architecture, you can go to `Specified CPU architecture`_.

Generic CPU
---------------------------------------

If you've chosen generic CPU version, you want to build the most common
tensorflow package. It means you probably don't need to use
modern instructions as SSE, AVX, etc.
Another option is you want to decide excatly what instructions you want to
enable and/or disable.

Lets assume, you want to build the simplest tensorflow
(without any extra instructions). Please open *docker-compose.yml* file,
find *tensorflow-builder* section and choose generic dockerfile:

.. code-block:: bash

    tensorflow-builder:
      image: tensorflow-builder
      build:
        context: ./
        cache_from:
          - tensorflow-builder
        # Generic architecture for most processors
        dockerfile: ./builder/generic/Dockerfile
        # Please ensure you have commented another
        # dockerfile entries for this image, for example:
        # dockerfile: ./builder/arch/Dockerfile

This configuration allows you to build the simplest version of tensorflow.

Another option for generic compiling process is when **you want to have all
control** what instructions of CPU you enable or disable.

For that case you additionally have to edit *Dockerfile*:

.. code-block:: bash

    vi builder/generic/Dockerfile

Take a while and decide what instructions you want to enable and disable.
Lets assume we want to enable only *MMX*, *SSE* and *SSE2* instructions.
We also want to be sure, we have disabled *AVX* instructions. Given this
conditionals we can setup *builder/generic/Dockerfile*:

.. code-block:: bash

    ...

    RUN python ./configure.py && \
        bazel build \
            --config=opt \
            \
            # decide what instructions you will enable, uncomment what needed
            --copt=-mmmx \
            --copt=-msse \
            --copt=-msse2 \
            \
            # decide what instructions you will disable, uncomment what needed
            --copt=-mno-avx \

            ...

For further investigation please also check `gcc compilation flags`_
and choose proper compilation options for chosen gcc_.

**IMPORTANT** - in that case we ignore *CC_OPT_FLAGS* in *.env* file.

Specified CPU architecture
---------------------------------------

If you want to build specified architecture, edit *docker-compose.yml* file,
find *tensorflow-builder* section and choose arch dockerfile:

.. code-block:: bash

    tensorflow-builder:
      image: tensorflow-builder
      build:
        context: ./
        cache_from:
          - tensorflow-builder
        # Please ensure you have commented another
        # dockerfile entries for this image, for example:
        # dockerfile: ./builder/generic/Dockerfile
        # Image for specified architecture
        dockerfile: ./builder/arch/Dockerfile

**IMPORTANT** - in this case you can't decide what
extra instructions you want to enable or disable.
It's only possible for `Generic CPU`_ mode.

Next step is to edit *.env* file and set proper *CC_OPT_FLAGS* value.
For example, lets assume we want to build tensorflow with native architecture
(building process will use compiling machine CPU for determining
the processor type).

.. code-block:: bash

    CC_OPT_FLAGS=-mtune=native

Another examples:

.. code-block:: bash

    # Intel Core2 CPU with 64-bit extensions, MMX, SSE, SSE2, SSE3 and SSSE3 instruction set support.
    CC_OPT_FLAGS=-mtune=core2

    # OR

    # Intel Atom CPU with 64-bit extensions, MMX, SSE, SSE2, SSE3 and SSSE3 instruction set support.
    CC_OPT_FLAGS=-mtune=atom

    # OR

    # Intel Pentium4 CPU with MMX, SSE and SSE2 instruction set support.
    CC_OPT_FLAGS=-mtune=pentium4

    # OR
    CC_OPT_FLAGS=[your architecture]


Advanced configuration
-----------------------------------------



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
