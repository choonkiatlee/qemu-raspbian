# #!/bin/bash

# Build one by one
cd buster_build
docker build --tag choonkiatlee/raspbian:buster-build .
docker tag choonkiatlee/raspbian:buster-build choonkiatlee/raspbian:build
docker tag choonkiatlee/raspbian:buster-build choonkiatlee/raspbian:latest

docker push choonkiatlee/raspbian:buster-build

cd ../buster_slim 
docker build --tag choonkiatlee/raspbian:buster-slim .
docker tag choonkiatlee/raspbian:buster-slim choonkiatlee/raspbian:slim

docker push choonkiatlee/raspbian:buster-slim

cd ../buster_faithful
docker build --tag choonkiatlee/raspbian:buster-faithful .
docker tag choonkiatlee/raspbian:buster-faithful choonkiatlee/raspbian:faithful

docker push choonkiatlee/raspbian:buster-faithful

# Push common tags
docker push choonkiatlee/raspbian:faithful
docker push choonkiatlee/raspbian:build
docker push choonkiatlee/raspbian:slim

docker push choonkiatlee/raspbian:latest



#!/bin/bash

# To build all using the multistage build 
# docker build --target buster_slim --tag choonkiatlee/qemu-raspbian:buster_slim .
# docker tag choonkiatlee/qemu-raspbian:buster_slim choonkiatlee/qemu-raspbian:slim

# docker build --target buster_latest --tag choonkiatlee/qemu-raspbian:buster_latest .
# docker tag choonkiatlee/qemu-raspbian:buster_latest choonkiatlee/qemu-raspbian:latest

# docker build --target buster_faithful --tag choonkiatlee/qemu-raspbian:buster_faithful .
# docker tag choonkiatlee/qemu-raspbian:buster_faithful choonkiatlee/qemu-raspbian:faithful
