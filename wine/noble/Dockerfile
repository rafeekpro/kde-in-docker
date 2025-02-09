# Base image with KDE and VNC
FROM rafeekpro/kde-vnc:noble

ARG MONO_VER="9.4.0"
ARG GECKO_VER="2.47.4-rc1"

# Create installation directory
RUN mkdir -p /_install

# Install essential utilities
RUN apt update && apt install -y --no-install-recommends \
    software-properties-common \
    gnupg2 \
    wget \
    ca-certificates


# Download and add WineHQ key
RUN wget -qO- https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor > /usr/share/keyrings/winehq-archive-keyring.gpg

# Add WineHQ repository
RUN echo "deb [signed-by=/usr/share/keyrings/winehq-archive-keyring.gpg] https://dl.winehq.org/wine-builds/ubuntu/ noble main" | tee /etc/apt/sources.list.d/winehq.list && \
    apt update

    
# Install Wine
RUN apt update && apt-cache search winehq
# Install Wine from Ubuntu's official repository
RUN apt update && apt install -y wine


# Create directories for Wine
RUN mkdir -p /usr/share/wine/mono /usr/share/wine/gecko

# Add Wine Mono & Gecko
ADD https://dl.winehq.org/wine/wine-mono/${MONO_VER}/wine-mono-${MONO_VER}-x86.msi /usr/share/wine/mono/
ADD https://dl.winehq.org/wine/wine-gecko/${GECKO_VER}/wine-gecko-${GECKO_VER}-x86.msi /usr/share/wine/gecko/
ADD https://dl.winehq.org/wine/wine-gecko/${GECKO_VER}/wine-gecko-${GECKO_VER}-x86_64.msi /usr/share/wine/gecko/

# Install Winetricks
ADD https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks /usr/bin/winetricks
RUN apt install -y --no-install-recommends wget zenity && \
    chmod +x /usr/bin/winetricks

# Copy additional configurations
COPY _root /
ENV PAGE_TITLE=Wine

# Cleanup to reduce image size
RUN apt autoremove -y && \
    apt clean && \
    rm -rf /_install /var/lib/apt/lists/*
