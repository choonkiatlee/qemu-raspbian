FROM choonkiatlee/raspbian:image-build as buster_build_builder

RUN qemu-debootstrap --variant='buildd' \
                    --keyring=/etc/apt/trusted.gpg \
                    --include=libopenblas-dev,libblas-dev,cmake,python3-dev,git,python3-pip,python3-setuptools \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

RUN chroot /rpi_rootfs apt-get clean

CMD ["chroot", "rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as buster_build
LABEL maintainer="CK <choonkiat.lee@gmail.com>; https://github.com/choonkiatlee/qemu-raspbian"
COPY --from=buster_build_builder /rpi_rootfs /
CMD ["/bin/bash"]


# Old version for building on docker hub
# RUN debootstrap --variant='minbase' \
#                     --foreign --no-check-gpg --include=ca-certificates \
#                     --keyring=/etc/apt/trusted.gpg \
#                     --include=libopenblas-dev,libblas-dev,cmake,python3-dev,git,python3-pip,python3-setuptools \
#                     --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian && \
#                     proot -r /rpi_rootfs -q qemu-arm-static \
# 		            /debootstrap/debootstrap --second-stage --verbose 