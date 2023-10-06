FROM ubuntu:jammy

LABEL Description="Dockerized MiKTeX, Ubuntu 22.04"
LABEL Vendor="Christian Schenk"
LABEL Version="23.10.5"

ARG DEBIAN_FRONTEND=noninteractive

ARG user=miktex
ARG group=miktex
ARG uid=1000
ARG gid=1000

ARG miktex_home=/var/lib/miktex
ARG miktex_work=/miktex/work

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${miktex_home}" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
           ca-certificates \
           curl \
           dirmngr \
           ghostscript \
           gnupg \
           gosu \
           perl

RUN curl -fsSL https://miktex.org/download/key | tee /usr/share/keyrings/miktex-keyring.asc > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/miktex-keyring.asc] https://miktex.org/download/ubuntu jammy universe" | tee /etc/apt/sources.list.d/miktex.list

RUN    apt-get update -y \
    && apt-get install -y --no-install-recommends \
           miktex

USER ${user}

RUN    miktexsetup finish \
    && initexmf --set-config-value=[MPM]AutoInstall=1 \
    && miktex packages update \
    && miktex packages install amsfonts

VOLUME [ "${miktex_home}" ]

WORKDIR ${miktex_work}

USER root
    
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

ENV PATH=/var/lib/miktex/bin:${PATH}

CMD ["bash"]
