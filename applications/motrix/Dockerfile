# Base image with KDE and VNC
FROM rafeekpro/kde-vnc:noble

ARG VERSION="1.8.19"

# Create an installation directory
RUN mkdir /_install

# Enable amd64 architecture
RUN dpkg --add-architecture amd64

# Fix Ubuntu repository issues
RUN echo "deb http://ports.ubuntu.com/ubuntu-ports noble main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://ports.ubuntu.com/ubuntu-ports noble-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://ports.ubuntu.com/ubuntu-ports noble-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://ports.ubuntu.com/ubuntu-ports noble-security main restricted universe multiverse" >> /etc/apt/sources.list || true && \
    apt update --fix-missing || true && \
    apt install -y --no-install-recommends \
        libuuid1:amd64 \
        libsecret-1-0:amd64 \
        libappindicator3-1:amd64 || true && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Install Motrix
ADD https://github.com/agalwood/Motrix/releases/download/v${VERSION}/Motrix_${VERSION}_amd64.deb /_install
RUN apt install -y /_install/Motrix_${VERSION}_amd64.deb || true

# Set up Python environment using `venv` (fixes PEP 668 issues)
RUN apt update && apt install -y --no-install-recommends python3 python3-pip python3-venv || true && \
    python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --no-cache-dir --upgrade pip setuptools wheel cython numpy || true && \
    apt clean && rm -rf /var/lib/apt/lists/*
ENV PATH="/opt/venv/bin:$PATH"

# Copy necessary files
COPY root /
ENV PAGE_TITLE=Motrix

# Cleanup to reduce image size
RUN apt autoremove -y && \
    apt clean && \
    rm -rf /_install /var/lib/apt/lists/*
