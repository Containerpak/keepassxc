FROM ubuntu:26.04 AS source

ADD --checksum=sha256:564fe8b751b9ef7aa057e4d3d0b2878db24eaa0f6b1c855c82e699ab0913ae49 https://github.com/keepassxreboot/keepassxc/releases/download/2.7.12/KeePassXC-2.7.12-x86_64.AppImage /tmp/source

RUN chmod 0755 /tmp/source && \
    cd /tmp && \
    ./source --appimage-extract >/dev/null && \
    mkdir -p /out/usr/bin && \
    cp -a /tmp/squashfs-root/usr/. /out/usr/ && \
    install -m 0755 /tmp/squashfs-root/AppRun /out/usr/bin/keepassxc

FROM ghcr.io/containerpak/gtk3:main

COPY --from=source /out/usr/ /usr/

RUN apt-get update && \
    apt-get install -y --no-install-recommends libpcsclite1 && \
    cpak-clean-junk
