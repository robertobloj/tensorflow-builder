# TensorFlow sources

Image contains [tensorflow](https://www.tensorflow.org) sources downloaded
from [github](https://github.com/tensorflow/tensorflow).

## How to use image?

By default you don't need to do anything except run image:

```
docker run -it robloj/tensorflow-sources
```

When image is downloaded, you can check if sources exist:

```
root@874c71f92f04:/# ls -la / | grep tensorflow
drwxr-xr-x   5 root root 4096 Jul  9 20:38 tensorflow-r1.14
```

In example above we have downloaded 1.14 version.
By default directory where we extracted tensorflow sources is a working directory.

Lets check what is inside working dir:

```
root@874c71f92f04:/tensorflow-r1.14# ls -la
total 376
drwxr-xr-x  6 root root   4096 Oct 14 21:08 .
drwxr-xr-x  1 root root   4096 Dec 20 11:39 ..
-rw-r--r--  1 root root   6382 Oct 14 21:08 .bazelrc
drwxr-xr-x  3 root root   4096 Oct 14 21:08 .github
-rw-r--r--  1 root root    776 Oct 14 21:08 .gitignore
-rw-r--r--  1 root root   2219 Oct 14 21:08 ACKNOWLEDGMENTS
-rw-r--r--  1 root root    542 Oct 14 21:08 ADOPTERS.md
-rw-r--r--  1 root root    349 Oct 14 21:08 AUTHORS
-rw-r--r--  1 root root    122 Oct 14 21:08 BUILD
-rw-r--r--  1 root root   3094 Oct 14 21:08 CODEOWNERS
-rw-r--r--  1 root root   5363 Oct 14 21:08 CODE_OF_CONDUCT.md
-rw-r--r--  1 root root   9516 Oct 14 21:08 CONTRIBUTING.md
-rw-r--r--  1 root root    598 Oct 14 21:08 ISSUES.md
-rw-r--r--  1 root root   2184 Oct 14 21:08 ISSUE_TEMPLATE.md
-rw-r--r--  1 root root  11419 Oct 14 21:08 LICENSE
-rw-r--r--  1 root root  12223 Oct 14 21:08 README.md
-rw-r--r--  1 root root 171860 Oct 14 21:08 RELEASE.md
-rw-r--r--  1 root root  13161 Oct 14 21:08 SECURITY.md
-rw-r--r--  1 root root   5554 Oct 14 21:08 WORKSPACE
-rw-r--r--  1 root root   1186 Oct 14 21:08 arm_compiler.BUILD
-rwxr-xr-x  1 root root    285 Oct 14 21:08 configure
-rw-r--r--  1 root root    780 Oct 14 21:08 configure.cmd
-rw-r--r--  1 root root  57914 Oct 14 21:08 configure.py
-rw-r--r--  1 root root    328 Oct 14 21:08 models.BUILD
drwxr-xr-x 18 root root   4096 Oct 14 21:08 tensorflow
drwxr-xr-x 41 root root   4096 Oct 14 21:08 third_party
drwxr-xr-x  2 root root   4096 Oct 14 21:08 tools
```

## How to build my own tensorflow sources image?

If you want to build your own tensorflow sources image, you have to provide tensorflow
version. For example:

```
docker build --build-arg TF_VERSION=r1.14 -t tensorflow-sources .
```

Where:

- TF_VERSION - [TensorFlow](https://github.com/tensorflow/tensorflow) version you want to use
