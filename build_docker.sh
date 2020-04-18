#!/bin/bash

docker build --target slim_builder --tag choonkiatlee/qemu-raspbian:slim_builder .
docker build --target slim --tag choonkiatlee/qemu-raspbian:slim .

docker build --target latest_builder --tag choonkiatlee/qemu-raspbian:latest_builder .
docker build --target latest --tag choonkiatlee/qemu-raspbian:latest .

