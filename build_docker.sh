# #!/bin/bash

# Build one by one
cd buster_build
docker build --tag choonkiatlee/qemu-raspbian:buster-build .
docker tag choonkiatlee/qemu-raspbian:buster-build choonkiatlee/qemu-raspbian:build
docker tag choonkiatlee/qemu-raspbian:buster-build choonkiatlee/qemu-raspbian:latest

docker push choonkiatlee/qemu-raspbian:buster-build

cd ../buster_slim 
docker build --tag choonkiatlee/qemu-raspbian:buster-slim .
docker tag choonkiatlee/qemu-raspbian:buster-slim choonkiatlee/qemu-raspbian:slim

docker push choonkiatlee/qemu-raspbian:buster-slim

cd ../buster_faithful
docker build --tag choonkiatlee/qemu-raspbian:buster-faithful .
docker tag choonkiatlee/qemu-raspbian:buster-faithful choonkiatlee/qemu-raspbian:faithful

docker push choonkiatlee/qemu-raspbian:buster-faithful

# Push common tags
docker push choonkiatlee/qemu-raspbian:faithful
docker push choonkiatlee/qemu-raspbian:build
docker push choonkiatlee/qemu-raspbian:slim

docker push choonkiatlee/qemu-raspbian:latest



#!/bin/bash

# To build all using the multistage build 
# docker build --target buster_slim --tag choonkiatlee/qemu-raspbian:buster_slim .
# docker tag choonkiatlee/qemu-raspbian:buster_slim choonkiatlee/qemu-raspbian:slim

# docker build --target buster_latest --tag choonkiatlee/qemu-raspbian:buster_latest .
# docker tag choonkiatlee/qemu-raspbian:buster_latest choonkiatlee/qemu-raspbian:latest

# docker build --target buster_faithful --tag choonkiatlee/qemu-raspbian:buster_faithful .
# docker tag choonkiatlee/qemu-raspbian:buster_faithful choonkiatlee/qemu-raspbian:faithful
