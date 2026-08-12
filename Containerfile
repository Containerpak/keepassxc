FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:564fe8b751b9ef7aa057e4d3d0b2878db24eaa0f6b1c855c82e699ab0913ae49 https://github.com/keepassxreboot/keepassxc/releases/download/2.7.12/KeePassXC-2.7.12-x86_64.AppImage /tmp/source

RUN apt-get update && \
    apt-get install -y --no-install-recommends fuse3 libpcsclite1 && \
    chmod +x /tmp/source && cd /tmp && ./source --appimage-extract >/dev/null && cp -a /tmp/squashfs-root/usr/. /usr/ && install -m 0755 /tmp/squashfs-root/AppRun /usr/bin/keepassxc && \
    cpak-clean-junk
