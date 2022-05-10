FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN    apt-get update \
    && apt-get install -y texlive-full texlive-lang-all

WORKDIR /tex/work
