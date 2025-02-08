FROM rafeekpro/kde-vnc:bionic

ARG VERSION="1.8.19"

RUN mkdir /_install


# Install
ADD https://github.com/agalwood/Motrix/releases/download/v${VERSION}/Motrix_${VERSION}_amd64.deb /_install
RUN apt install -y /_install/Motrix_${VERSION}_amd64.deb


# All Dependencies Satisfied
COPY root /
ENV PAGE_TITLE=Motrix


# Cleanup
RUN apt autoremove -y && \
    apt clean && \
    rm -r /_install
