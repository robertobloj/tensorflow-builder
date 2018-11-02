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

What builder image do I need?
----------------------------------

We provided following images for compiling process:

- builder/core2 - image compiles tensorflow optimized for Intel Core2 CPU with 64-bit extensions, MMX, SSE, SSE2, SSE3 and SSSE3 instruction set support.
- builder/generic - image compiles tensorflow optimized for the most common *IA32/AMD64/EM64T* processors.
- builder/native - image compiles tensorflow optimized for the local machine under the constraints of the selected instruction set
- builder/pentium4 - image compiles tensorflow optimized for Intel Pentium4 CPU with *MMX*, *SSE* and *SSE2* instruction set support.

You can also easily build your own Dockerfile based on examples above.

How to use it?
-----------------------------------

TODO

.. _install from sources: https://www.tensorflow.org/install/install_sources
.. _bazel: https://docs.bazel.build/
.. _tensorflow: https://www.tensorflow.org
.. _github: https://github.com/tensorflow/tensorflow
.. _coreinfo: https://docs.microsoft.com/pl-pl/sysinternals/downloads/coreinfo
.. _page: https://docs.microsoft.com/en-us/windows-server/get-started/system-requirements
.. _gcc compilation flags: https://gcc.gnu.org/onlinedocs/gcc-4.5.3/gcc/i386-and-x86_002d64-Options.html
.. _gcc: https://gcc.gnu.org/
