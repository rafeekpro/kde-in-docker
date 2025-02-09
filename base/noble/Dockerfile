FROM ubuntu:noble

ARG S6_VER="3.2.0.2"
ARG NO_VNC_VER="1.5.0"
ARG WEB_SOCK_VER="0.12.0"

# Create installation directory and install essential utilities
RUN mkdir /_install && \
    apt update && apt install -y --no-install-recommends xz-utils unzip curl wget python3 python3-pip python3-venv nginx gettext-base && \
    apt clean && rm -rf /var/lib/apt/lists/*

## Install S6 Overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-x86_64.tar.xz /_install/s6-overlay-x86_64.tar.xz
RUN tar -xJf /_install/s6-overlay-x86_64.tar.xz -C / && rm -r /_install
ENTRYPOINT ["/init"]

## KDE Desktop Environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y --no-install-recommends plasma-desktop nautilus konsole && \
    apt remove -y bluedevil && \
    [ -f /usr/bin/startkde ] && sed -i 's/.*kdeinit/###&/' /usr/bin/startkde || echo "startkde not found, skipping sed" && \
    apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*

## Install VNC Server
RUN apt update && \
    apt install -y --no-install-recommends tigervnc-standalone-server tigervnc-xorg-extension && \
    apt clean && rm -rf /var/lib/apt/lists/*
ENV DISPLAY=:0 \
    SCR_WIDTH=1600 \
    SCR_HEIGHT=900
EXPOSE 5900

## Install NoVNC & Websockify
ADD https://github.com/novnc/noVNC/archive/refs/tags/v${NO_VNC_VER}.zip /_install/noVNC-${NO_VNC_VER}.zip
ADD https://github.com/novnc/websockify/archive/v${WEB_SOCK_VER}.zip /_install/websockify-${WEB_SOCK_VER}.zip
RUN cd /_install && \
    unzip noVNC-${NO_VNC_VER}.zip && \
    unzip websockify-${WEB_SOCK_VER}.zip && \
    mv noVNC-${NO_VNC_VER} /novnc && \
    mv websockify-${WEB_SOCK_VER} /novnc/utils/websockify && \
    rm -rf /_install
EXPOSE 8080
ENV PATH_PREFIX=/ \
    VNC_RESIZE=scale \
    RECON_DELAY=250 \
    PAGE_TITLE=KDE

## Set up Python environment using `venv` (avoids PEP 668 issues)
RUN python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --no-cache-dir --upgrade pip setuptools wheel cython numpy
ENV PATH="/opt/venv/bin:$PATH"

## Create user `kid`
ENV PGID=0 \
    PUID=0 \
    ROOT_PASSWORD=password \
    HOME=/config
RUN useradd -U -u 6006 -d "$HOME" kid && usermod -G users kid
WORKDIR /

## Copy configuration files
COPY _root/ /
COPY noble/root/ /

## Final cleanup to reduce image size
RUN apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*
