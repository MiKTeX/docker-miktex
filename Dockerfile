ARG VARIANT=focal
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

LABEL Description="Dockerized MiKTeX, Ubuntu 20.04" Vendor="Christian Schenk" Version="21.7"

ARG DEBIAN_FRONTEND=noninteractive

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

RUN apt-get update && \ 
  # basic utilities for TeX Live installation
  apt-get install -y wget rsync unzip git gpg tar xorriso \ 
  # miscellaneous dependencies for TeX Live tools
  make fontconfig perl default-jre libgetopt-long-descriptive-perl \
  libdigest-perl-md5-perl libncurses5 libncurses6 \
  # for latexindent (see #13)
  libunicode-linebreak-perl libfile-homedir-perl libyaml-tiny-perl \
  # for eps conversion (see #14)
  ghostscript \
  # for l3build CTAN upload
  curl \
  # for syntax highlighting
  python3 python3-pygments && \ 
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apt/ && \ 
  # bad fix for python handling
  ln -s /usr/bin/python3 /usr/bin/python
  
RUN apt-get update && apt-get install -y inkscape

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
RUN echo "deb http://miktex.org/download/ubuntu focal universe" | tee /etc/apt/sources.list.d/miktex.list

RUN    apt-get update -y \
    && apt-get install -y --no-install-recommends \
           miktex

RUN    miktexsetup finish \
    && initexmf --admin --set-config-value=[MPM]AutoInstall=1 \
    && mpm --admin --update-db \
    && mpm --admin \
           --install amsfonts \
           --install biber-linux-x86_64 \
    && initexmf --admin --update-fndb

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

ENV MIKTEX_USERCONFIG=/miktex/.miktex/texmfs/config
ENV MIKTEX_USERDATA=/miktex/.miktex/texmfs/data
ENV MIKTEX_USERINSTALL=/miktex/.miktex/texmfs/install

WORKDIR /miktex/work

CMD ["sleep", "infinity"]
