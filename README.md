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

root@b0571199906e:/# apt-get update && apt-get install gfortran

root@b0571199906e:/# pip3 install cython wheel

root@b0571199906e:/# git clone https://github.com/numpy/numpy.git

root@b0571199906e:/# cd numpy

root@b0571199906e:/# python3 setup.py build -j 4 bdist_wheel

root@b0571199906e:/# exit

docker cp numpy_builder:/numpy/dist/*.whl .
```

## Example: Build Pytorch wheels (Time taken: )
```bash
$ docker run -it --name numpy_builder choonkiatlee/raspbian-qemu:latest

# In Docker Container
apt-get update && apt-get install -y python3-cffi python3-numpy

pip3 install cython wheel

git clone --recursive https://github.com/pytorch/pytorch

cd pytorch

# Configure pytorch build options
export USE_CUDA=0
export USE_CUDNN=0
export USE_MKLDNN=0
export USE_NNPACK=1
export USE_QNNPACK=1
export USE_DISTRIBUTED=0
export BUILD_TEST=0
export MAX_JOBS=4

python3 setup.py bdist_wheel




# Install python dependencies
root@b0571199906e:/# pip3 install cython wheel numpy cffi




```
