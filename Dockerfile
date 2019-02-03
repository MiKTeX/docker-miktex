FROM ubuntu:bionic

LABEL Description="Dockerized MiKTeX, Ubuntu 18.04" Vendor="Christian Schenk" Version="2.9.6970"

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
           ca-certificates \
           dirmngr \
           ghostscript \
           gnupg \
           gosu \
           make \
           perl

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
RUN echo "deb http://miktex.org/download/ubuntu bionic universe" | tee /etc/apt/sources.list.d/miktex.list

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           miktex

RUN    miktexsetup finish \
    && initexmf --admin --set-config-value=[MPM]AutoInstall=1 \
    && mpm --admin --update-db \
    && mpm --admin \
           --install amsfonts \
           --install biber-linux-x86_64

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /miktex/work

CMD ["bash"]
