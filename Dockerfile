FROM ubuntu:18.04 as base

# Install common packages required
FROM base as image_build

RUN apt-get update && \
    apt-get install  -y --no-install-recommends \
            debootstrap \
            gnupg \
            proot \
            qemu-user-static && \
    rm -rf /var/lib/apt/lists/*

# patch debootstrap as /proc cannot be mounted under proot
RUN	sed -i 's/in_target mount -t proc/#in_target mount -t proc/g' /usr/share/debootstrap/functions

# Master Raspbian Repo from https://www.raspbian.org/RaspbianRepository
RUN wget --no-check-certificate https://archive.raspbian.org/raspbian.public.key -O - | apt-key add -q

######################### Buster Build version #####################################

FROM choonkiatlee/qemu-raspbian:image_build as buster_build_builder

RUN qemu-debootstrap --variant='buildd' \
                    --keyring=/etc/apt/trusted.gpg \
                    --include=libopenblas-dev,libblas-dev,cmake,python3-dev,git,python3-pip,python3-setuptools \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

# RUN debootstrap --variant='minbase' \
#                     --foreign --no-check-gpg --include=ca-certificates \
#                     --keyring=/etc/apt/trusted.gpg \
#                     --include=libopenblas-dev,libblas-dev,cmake,python3-dev,git,python3-pip,python3-setuptools \
#                     --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian && \
#                     chroot -r /rpi_rootfs -q qemu-arm-static \
# 		            /debootstrap/debootstrap --second-stage --verbose 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

RUN chroot /rpi_rootfs apt-get clean

CMD ["chroot", "rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as buster_build_builder
COPY --from=buster_build /rpi_rootfs /
CMD ["/bin/bash"]

######################### Buster Slim version #####################################

FROM choonkiatlee/qemu-raspbian:image_build as buster_slim_builder

RUN qemu-debootstrap --variant='buildd' \
                    --keyring=/etc/apt/trusted.gpg \
                    --include=python3,git,python3-pip \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

RUN chroot /rpi_rootfs apt-get clean

# Just in case you want to check the builder image
CMD ["chroot", "/rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as buster_slim
COPY --from=buster_slim_builder /rpi_rootfs /
CMD ["/bin/bash"]




