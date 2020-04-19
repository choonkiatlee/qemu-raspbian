From scratch
ADD *.tgz /
CMD ["qemu-arm-static", "/bin/bash"]

# FROM choonkiatlee/qemu-raspbian:image_build as buster_faithful_builder

# RUN qemu-debootstrap --keyring=/etc/apt/trusted.gpg \
#                     --include=python3,git,python3-pip \
#                     --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

# RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

# RUN chroot /rpi_rootfs apt-get clean

# # Just in case you want to check the builder image
# CMD ["chroot", "/rpi_rootfs/", "/bin/bash"]

# # Create minimal boot file
# FROM scratch as buster_faithful
# LABEL maintainer="CK <choonkiat.lee@gmail.com>; https://github.com/choonkiatlee/qemu-raspbian"
# COPY --from=buster_faithful_builder /rpi_rootfs /
# CMD ["/bin/bash"]