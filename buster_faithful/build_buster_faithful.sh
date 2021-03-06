#!/bin/bash

# Download the latest Raspbian Image
mkdir rpi_img
cd rpi_img
wget -q https://downloads.raspberrypi.org/raspbian_lite_latest # -q for more sane logging

# Unzip the Image
RPI_IMG_FILENAME=`unzip -Z -1 raspbian_lite_latest`
RPI_IMG_BASENAME="${RPI_IMG_FILENAME%.*}"

# Debug purposes
echo RPI_IMG_FILENAME: $RPI_IMG_FILENAME, RPI_IMG_BASENAME: $RPI_IMG_BASENAME

unzip raspbian_lite_latest
rm raspbian_lite_latest

# Mount the Image
# These steps are currently preventing us from running this build step as part of a multistage docker build
# because we cannot run certain privileged commands such as mount in a docker container during building
cd ..
mkdir rpi_mnt
ls -lh rpi_img/$RPI_IMG_FILENAME

LOOP_DEVICE=`sudo losetup -f`

sudo losetup -f -P --show rpi_img/$RPI_IMG_FILENAME
echo LOOP_DEVICE mounted on ${LOOP_DEVICE}p2

sudo mount ${LOOP_DEVICE}p2 -o rw rpi_mnt
# sudo mount /dev/loop0p2 -o rw rpi_mnt

# Copy the quemu-arm-static binary into the image to be produced
sudo cp /usr/bin/qemu-arm-static rpi_mnt/usr/bin

# Prevent preload errors on docker
sudo mv rpi_mnt/etc/ld.so.preload rpi_mnt/etc/ld.so.preload.backup
sudo touch rpi_mnt/etc/ld.so.preload

mkdir rpi_zipped_img
cd rpi_mnt
sudo tar -czf ../rpi_zipped_img/$RPI_IMG_BASENAME.tgz .
cd ..

sudo umount rpi_mnt
sudo losetup -d /dev/loop0

cd rpi_zipped_img
docker build -f ../Dockerfile --tag choonkiatlee/raspbian:buster-faithful .
docker tag choonkiatlee/raspbian:buster-faithful choonkiatlee/raspbian:faithful

cd ..
sudo rm -r rpi_img rpi_mnt rpi_zipped_img



