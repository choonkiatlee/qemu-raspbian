FROM choonkiatlee/qemu-raspbian:image_build as buster_build_builder

RUN qemu-debootstrap --variant='buildd' \
                    --keyring=/etc/apt/trusted.gpg \
                    --include=libopenblas-dev,libblas-dev,cmake,python3-dev,git,python3-pip,python3-setuptools \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

CMD ["chroot", "rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as buster_build_builder
COPY --from=buster_build /rpi_rootfs /
CMD ["/bin/bash"]