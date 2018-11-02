# TensorFlow sources

Image contains [tensorflow](https://www.tensorflow.org) sources downloaded from [github](https://github.com/tensorflow/tensorflow).

## How to use image?

By default you don't need to do anything except run image:

```
docker run -it robloj/tensorflow-sources
```

When image is downloaded, you can check if sources exist:

```
root@874c71f92f04:/# ls -la / | grep tensorflow
drwxr-xr-x   5 root root 4096 Jul  9 20:38 tensorflow-r1.11
```

In example above we have downloaded 1.11 version.
By default directory where we extracted tensorflow sources is a working directory.

Lets check what is inside working dir:

```
root@874c71f92f04:/tensorflow-r1.11# ls -la
total 288
drwxr-xr-x  5 root root   4096 Jul  9 20:38 .
drwxr-xr-x  1 root root   4096 Aug 12 07:14 ..
-rw-r--r--  1 root root    653 Jul  9 20:38 .gitignore
-rw-r--r--  1 root root   2219 Jul  9 20:38 ACKNOWLEDGMENTS
-rw-r--r--  1 root root    542 Jul  9 20:38 ADOPTERS.md
-rw-r--r--  1 root root    349 Jul  9 20:38 AUTHORS
-rw-r--r--  1 root root     77 Jul  9 20:38 BUILD
-rw-r--r--  1 root root   2490 Jul  9 20:38 CODEOWNERS
-rw-r--r--  1 root root   5310 Jul  9 20:38 CODE_OF_CONDUCT.md
-rw-r--r--  1 root root   9041 Jul  9 20:38 CONTRIBUTING.md
-rw-r--r--  1 root root   2056 Jul  9 20:38 ISSUE_TEMPLATE.md
-rw-r--r--  1 root root  11416 Jul  9 20:38 LICENSE
-rw-r--r--  1 root root   6063 Jul  9 20:38 README.md
-rw-r--r--  1 root root 108770 Jul  9 20:38 RELEASE.md
-rw-r--r--  1 root root  13963 Jul  9 20:38 SECURITY.md
-rw-r--r--  1 root root   3610 Jul  9 20:38 WORKSPACE
-rw-r--r--  1 root root   1186 Jul  9 20:38 arm_compiler.BUILD
-rwxr-xr-x  1 root root    285 Jul  9 20:38 configure
-rw-r--r--  1 root root  58495 Jul  9 20:38 configure.py
-rw-r--r--  1 root root    328 Jul  9 20:38 models.BUILD
drwxr-xr-x 16 root root   4096 Jul  9 20:38 tensorflow
drwxr-xr-x 26 root root   4096 Jul  9 20:38 third_party
drwxr-xr-x  2 root root   4096 Jul  9 20:38 tools
```

## How to build my own tensorflow sources image?

If you want to build your own tensorflow sources image, you have to provide tensorflow
version. For example:

```
docker build --build-arg TF_VERSION=1.11 -t my-tensorflow-sources .
```

Where:

- TF_VERSION - [TensorFlow](https://github.com/tensorflow/tensorflow) version you want to use
