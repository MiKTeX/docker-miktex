FROM ubuntu:xenial

LABEL Description="Dockerized MiKTeX, Ubuntu 16.04" Vendor="Christian Schenk" Version="2.9.6526"

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
RUN echo "deb http://miktex.org/download/ubuntu xenial universe" | tee /etc/apt/sources.list.d/miktex.list
RUN apt-get update
RUN apt-get install apt-transport-https -y
RUN apt-get install miktex -y

RUN apt-get install perl -y

RUN initexmf --admin --force --mklinks
RUN mpm --admin --install amsfonts
RUN initexmf --admin --mkmaps
RUN initexmf --admin --update-fndb

RUN useradd -md /miktex miktex
USER miktex
RUN mkdir /miktex/work
RUN mkdir /miktex/.miktex
WORKDIR /miktex/work
