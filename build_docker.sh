# #!/bin/bash

# # docker build --target slim_builder --tag $DOCKER_REPO/qemu-raspbian:slim_builder .
# docker build --target buster_slim --tag choonkiatlee/qemu-raspbian:buster_slim .

# docker tag choonkiatlee/qemu-raspbian:buster_slim choonkiatlee/qemu-raspbian:slim
# docker push choonkiatlee/qemu-raspbian:slim

# # docker build --target buster_latest_builder --tag $DOCKER_REPO/qemu-raspbian:buster_latest_builder .
# docker build --target buster_latest --tag choonkiatlee/qemu-raspbian:buster_latest .

# docker tag choonkiatlee/qemu-raspbian:buster_latest choonkiatlee/qemu-raspbian:latest
# docker push choonkiatlee/qemu-raspbian:latest

#!/bin/bash

# docker build --target slim_builder --tag $DOCKER_REPO/qemu-raspbian:slim_builder .
docker build --target buster_slim --tag choonkiatlee/qemu-raspbian:buster_slim .

docker tag choonkiatlee/qemu-raspbian:buster_slim choonkiatlee/qemu-raspbian:slim
docker push choonkiatlee/qemu-raspbian:slim

# docker build --target buster_latest_builder --tag $DOCKER_REPO/qemu-raspbian:buster_latest_builder .
docker build --target buster_latest --tag choonkiatlee/qemu-raspbian:buster_latest .

docker tag choonkiatlee/qemu-raspbian:buster_latest choonkiatlee/qemu-raspbian:latest
docker push choonkiatlee/qemu-raspbian:latest

# docker build --target buster_faithful_builder --tag $DOCKER_REPO/qemu-raspbian:buster_faithful_builder .
docker build --target buster_faithful --tag choonkiatlee/qemu-raspbian:buster_faithful .

docker tag choonkiatlee/qemu-raspbian:buster_faithful choonkiatlee/qemu-raspbian:faithful
docker push choonkiatlee/qemu-raspbian:faithful