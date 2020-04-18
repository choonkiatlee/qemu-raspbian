FROM ubuntu:18.04 as base


# Install common packages required
FROM base as image_build

RUN apt-get update && \
    apt-get install  -y --no-install-recommends \
            debootstrap \
            gnupg \
            qemu-user-static && \
    rm -rf /var/lib/apt/lists/*

# patch debootstrap as /proc cannot be mounted under proot
RUN	sed -i 's/in_target mount -t proc/#in_target mount -t proc/g' /usr/share/debootstrap/functions

# Master Raspbian Repo from https://www.raspbian.org/RaspbianRepository
RUN wget --no-check-certificate https://archive.raspbian.org/raspbian.public.key -O - | apt-key add -q


############################## Build slim #####################################################

FROM image_build as slim_builder

RUN qemu-debootstrap --variant='minbase' \
                    --keyring=/etc/apt/trusted.gpg \
                    --include=python3,git,python3-pip \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

CMD ["chroot", "rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as slim
COPY --from=slim_builder /rpi_rootfs /
CMD ["/bin/bash"]


############################## Build latest #####################################################

FROM image_build as latest_builder

RUN qemu-debootstrap --variant='buildd' \
                    --keyring=/etc/apt/trusted.gpg \
                    --include=libopenblas-dev,libblas-dev,cmake,python3-dev,git,python3-pip,python3-setuptools \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

CMD ["chroot", "rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as slim
COPY --from=latest_builder /rpi_rootfs /
CMD ["/bin/bash"]

############################## Build faithful #####################################################


# RUN tar -czvf raspbian_buster_minimal_`date +%Y_%m_%d`.tgz /rpi_rootfs

# Install minimal build files
# FROM scratch as image_minimal
# COPY --from=image_build /rpi_rootfs /
# CMD ["/bin/bash"]

# Install packages useful for build packages
# FROM image_minimal as builder

# RUN apt-get update && \
#     apt-get install  -y --no-install-recommends \
#             python3-pip \
#             python3-dev \
#             python3-setuptools \
#             libopenblas-dev \
#             libblas-dev \
#             cmake \
#             build-essential \
#             git && \
#     rm -rf /var/lib/apt/lists/*

# FROM scratch as buster
# ADD raspbian_buster_minimal_2020_04_18.tgz /
# CMD ["/bin/bash"]



# FROM base as image_build_download

# RUN apt-get update && \
#     apt-get install  -y --no-install-recommends \
#             wget \
#             ca-certificates \
#             unzip && \
#     rm -rf /var/lib/apt/lists/*

# RUN wget https://downloads.raspberrypi.org/raspbian_lite_latest

# RUN unzip raspbian_lite_latest

# RUN losetup --show *.img 
# RUN mkdir /rpi_mnt
# RUN mount /dev/loop0p2 -o rw /rpi_mnt


