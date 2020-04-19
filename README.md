# Raspbian Docker QEMU

This is a Docker container that allows you to run raspbian using QEMU. This can be used for a variety of purposes, such as using your own computer to build ARM binaries for the Raspberry Pi.

## Pre-Requisites

You need to install the qemu-user-static and binfmt-support packages. On your host system: 

```bash
sudo apt-get update && sudo apt-get install qemu qemu-user-static binfmt-support
```

## How To

1) Build Numpy wheels

```bash
$ docker run -it choonkiatlee/raspbian-qemu:latest

# ls dir to show that we are inside the R
root@b0571199906e:/# uname -a

root@b0571199906e:/# pip3 install cython wheel

root@b0571199906e:/# git clone https://github.com/numpy/numpy.git

root@b0571199906e:/# cd numpy

root@b0571199906e:/# python3 setup.py bdist_wheel

root@b0571199906e:/# exit

docker cp 


```

## Explanation for the Dockerfile

