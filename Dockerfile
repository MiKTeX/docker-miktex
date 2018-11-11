FROM ubuntu:xenial

LABEL Description="Dockerized MiKTeX, Ubuntu 16.04" Vendor="Christian Schenk" Version="2.9.6628"

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
RUN echo "deb http://miktex.org/download/ubuntu xenial universe" | tee /etc/apt/sources.list.d/miktex.list

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
	   ca-certificates

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
	   miktex \
	   perl

RUN useradd -md /miktex miktex
USER miktex

RUN miktexsetup finish
RUN initexmf --set-config-value=[MPM]AutoInstall=1
RUN mpm --install amsfonts

WORKDIR /miktex/work
