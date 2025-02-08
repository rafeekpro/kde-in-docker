# [KID - KDE in Docker](https://ms-jpq.github.io/kde-in-docker/)

Docker + VNC + noVNC web UI

**WHY?**

**So you can run KDE inside a browser**

## Usage

### Common Environmental Variables

#### Rootless

These images by default runs as root.

To change that, set these two variables to a non Zero value.

- `-e PGID=0`
- `-e PUID=0`

#### VNC

- `-e SCR_WIDTH=1600`
- `-e SCR_HEIGHT=900`

#### noVNC UI

- `-e PATH_PREFIX=/`
- `-e VNC_RESIZE=scale|remote|off` remote = rescale remote desktop, scale = stretch remote desktop
- `-e RECON_DELAY=250` reconnection delay (ms)
- `-e PAGE_TITLE=🐳`

#### Misc

This is your password even under non-root user

- `-e ROOT_PASSWORD=password`

### Common Ports

- `-p 80:8080` noVNC web UI

- `-p 5900:5900` VNC

### Common Volumes

- `-v ./appconfig:/config`

### Special Thanks

[McGriddle](https://github.com/McGriddle) for helping with rootless!

## Images

### [Firefox](https://hub.docker.com/r/rafeekpro/firefox-vnc/)

[![Docker Pulls](https://img.shields.io/docker/pulls/rafeekpro/firefox-vnc.svg)](https://hub.docker.com/r/rafeekpro/firefox-vnc/)

🦊

**RUN** - `docker run -p 8080:8080 -p 5900:5900 rafeekpro/firefox-vnc`

![firefox preview.png](https://github.com/ms-jpq/kde-in-docker/raw/daddy/preview/firefox.png)

---

### [Adobe Acrobat](https://hub.docker.com/r/rafeekpro/adobe-acrobat-vnc/)

[![Docker Pulls](https://img.shields.io/docker/pulls/rafeekpro/adobe-acrobat-vnc.svg)](https://hub.docker.com/r/rafeekpro/adobe-acrobat-vnc/)

Adobe PDF Reader `9.5.5`

(first launch slow)

**RUN** - `docker run -p 8080:8080 -p 5900:5900 rafeekpro/adobe-acrobat-vnc`

![acrobat preview.png](https://github.com/ms-jpq/kde-in-docker/raw/daddy/preview/acrobat.png)

---

### [Motrix](https://hub.docker.com/r/rafeekpro/motrix-vnc/)

[![Docker Pulls](https://img.shields.io/docker/pulls/rafeekpro/motrix-vnc.svg)](https://hub.docker.com/r/rafeekpro/motrix-vnc/)

Really cool download client. [https://motrix.app/](https://motrix.app/)

**`thunder://`** !! 迅雷

**RUN** - `docker run -p 8080:8080 -p 5900:5900 rafeekpro/motrix-vnc`

![motrix preview.png](https://github.com/ms-jpq/kde-in-docker/raw/daddy/preview/motrix.png)

---

### [Base:Ubuntu-Bionic](https://hub.docker.com/r/rafeekpro/kde-vnc/)

[![Docker Pulls](https://img.shields.io/docker/pulls/rafeekpro/kde-vnc.svg)](https://hub.docker.com/r/rafeekpro/kde-vnc/)

KDE on 18.04 lts. `620MB`

**RUN** - `docker run -p 8080:8080 -p 5900:5900 rafeekpro/kde-vnc:bionic`

![bionic preview.png](https://github.com/ms-jpq/kde-in-docker/raw/daddy/preview/bionic.png)

---

### [Base:Ubuntu-Focal](https://hub.docker.com/r/rafeekpro/kde-vnc/)

[![Docker Pulls](https://img.shields.io/docker/pulls/rafeekpro/kde-vnc.svg)](https://hub.docker.com/r/rafeekpro/kde-vnc/)

KDE on 20.04 lts. `730MB`

**RUN** - `docker run -p 8080:8080 -p 5900:5900 rafeekpro/kde-vnc:focal`

![focal preview.png](https://github.com/ms-jpq/kde-in-docker/raw/daddy/preview/focal.png)

---

### [Base:Wine-Bionic](https://hub.docker.com/r/rafeekpro/wine-vnc/)

[![Docker Pulls](https://img.shields.io/docker/pulls/rafeekpro/wine-vnc.svg)](https://hub.docker.com/r/rafeekpro/wine-vnc/)

WINE 5.3 with dependencies. `1.3GB`

**RUN** - `docker run -p 8080:8080 -p 5900:5900 rafeekpro/wine-vnc:bionic`

![wine preview.png](https://github.com/ms-jpq/kde-in-docker/raw/daddy/preview/wine.png)
