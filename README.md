# Raspbian Docker QEMU

This is a Docker container that allows you to run raspbian using QEMU. This can be used for a variety of purposes, such as using your own computer to build ARM binaries for the Raspberry Pi.

## Pre-Requisites

You need to install the qemu-user-static and binfmt-support packages (Both for building and running the docker containers). On your host system: 

```bash
sudo apt-get update && sudo apt-get install qemu qemu-user-static binfmt-support
```

Test to make sure that we are successfully running an ARM container on x86

```bash
docker run -it --rm choonkiatlee/raspbian-qemu:latest uname -a
> Linux 44cb9fc4aa70 5.0.0-1036-azure #38-Ubuntu SMP Sun Mar 22 21:27:21 UTC 2020 armv7l GNU/Linux
```

## Example: Build Numpy wheels (Time taken: )

```bash
$ docker run -it --name numpy_builder choonkiatlee/raspbian-qemu:latest

# ls dir to show that we are inside the R
root@b0571199906e:/# uname -a

root@b0571199906e:/# pip3 install cython wheel

root@b0571199906e:/# git clone https://github.com/numpy/numpy.git

root@b0571199906e:/# cd numpy

root@b0571199906e:/# python3 setup.py bdist_wheel

root@b0571199906e:/# exit

docker cp numpy_builder:/numpy/dist/*.whl .
```

## Example: Build Pytorch wheels (Time taken: )
```bash

```
