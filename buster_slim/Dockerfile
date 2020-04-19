FROM choonkiatlee/qemu-raspbian:image_build as buster_slim_builder

ENV PROOT_NO_SECCOMP 1

RUN debootstrap --variant='minbase' \
                    --foreign --no-check-gpg --include=ca-certificates \
                    --keyring=/etc/apt/trusted.gpg \
                    # --include=python3,git,python3-pip \
                    --arch armhf buster /rpi_rootfs http://archive.raspbian.org/raspbian && \
                    proot -r /rpi_rootfs -q qemu-arm-static \
		            /debootstrap/debootstrap --second-stage --verbose 

RUN echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free rpi" >> /rpi_rootfs/etc/apt/sources.list

RUN cp /usr/bin/qemu-arm-static /rpi_rootfs/usr/bin/qemu-arm-static

CMD ["chroot", "rpi_rootfs/", "/bin/bash"]

# Create minimal boot file
FROM scratch as buster_slim
COPY --from=buster_slim_builder /rpi_rootfs /
CMD ["/bin/bash"]
