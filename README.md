# Raspbian Docker QEMU

This is a Docker container that allows you to run raspbian using QEMU. This can be used for a variety of purposes, such as using your own computer to build ARM binaries for the Raspberry Pi.

## How To

1) Build Numpy wheels

```bash
docker pull choonkiatlee/raspbian-qemu:latest
docker run -it choonkiatlee/raspbian-qemu:latest .....
