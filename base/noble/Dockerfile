FROM ubuntu:noble

ARG S6_OVERLAY_VERSION="3.2.0.2"
ARG NO_VNC_VER="1.5.0"
ARG WEB_SOCK_VER="0.12.0"

RUN chmod 1777 /tmp

# Set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Install essential utilities
RUN apt update && \
    apt install -y --no-install-recommends \
        xz-utils unzip curl wget python3 python3-pip python3-venv \
        nginx gettext-base \
        plasma-desktop nautilus konsole \
        tigervnc-standalone-server tigervnc-xorg-extension && \
    apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*

# Create installation directory and install essential utilities
RUN mkdir /_install && \
    apt update && apt install -y --no-install-recommends xz-utils unzip curl wget python3 python3-pip python3-venv nginx gettext-base && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y nginx xz-utils
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
CMD ["/usr/sbin/nginx"]    

## Install S6 Overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz
ENTRYPOINT ["/init"]

## KDE Desktop Environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y --no-install-recommends plasma-desktop nautilus konsole && \
    apt remove -y bluedevil && \
    [ -f /usr/bin/startkde ] && sed -i 's/.*kdeinit/###&/' /usr/bin/startkde || echo "startkde not found, skipping sed" && \
    apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*

RUN chmod 1777 /tmp

## Install VNC Server
RUN apt update --allow-releaseinfo-change && \
    apt install -y --no-install-recommends tigervnc-standalone-server tigervnc-xorg-extension && \
    apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*
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
RUN chmod -R +x /etc/services.d/
RUN chmod +x /etc/cont-init.d/00--init-user.sh
RUN chmod +x /etc/cont-init.d/00-desktop.sh
RUN chmod +x /etc/cont-init.d/00-envsubst.sh
RUN chmod +x /etc/cont-init.d/01-desktop.sh
RUN chmod +x /etc/cont-init.d/01-nolock.sh
RUN chmod +x /etc/services.d/kde/run
RUN chmod +x /etc/services.d/nginx/run
RUN chmod +x /etc/services.d/novnc/run
RUN chmod +x /etc/services.d/tigervnc/run
RUN chmod +x /etc/services.d/vncconfig/run

## Final cleanup to reduce image size
RUN apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*
