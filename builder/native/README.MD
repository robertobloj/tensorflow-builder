# TensorFlow native binary

Image allows to compile [tensorflow](https://www.tensorflow.org)
from sources with *native mode*. Read more about *native mode* [here](https://gcc.gnu.org/onlinedocs/gcc-4.5.3/gcc/i386-and-x86_002d64-Options.html).

__IMPORTANT:__ Native architecture selects the CPU to tune
for at compilation time by determining the processor type of
the compiling machine. Using -mtune=native will produce code optimized
for the local machine under the constraints of
the selected instruction set. Using -march=native will enable
all instruction subsets supported by
the local machine (hence the result might not run on different machines).

Check more documentation on [github](https://github.com/robertobloj/tensorflow-builder).

## How to compile tensorflow with native mode?

Check instructions for [generic](../generic/README.MD)