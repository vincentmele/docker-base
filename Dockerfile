FROM ubuntu:trusty
MAINTAINER Vince Mele <vmele@inoc.com>

RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y vim.tiny gnupg wget net-tools ca-certificates unzip apt-transport-https \
 && rm -rf /var/lib/apt/lists/*
