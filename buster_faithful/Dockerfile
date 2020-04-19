FROM image_build as buster_faithful_builder

RUN qemu-debootstrap --keyring=/etc/apt/trusted.gpg \
                    --include=python3,git,python3-pip \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

CMD ["chroot", "rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as buster_faithful
COPY --from=buster_faithful_builder /rpi_rootfs /
CMD ["/bin/bash"]