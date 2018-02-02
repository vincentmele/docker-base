FROM ubuntu:xenial
MAINTAINER Vince Mele <vmele@inoc.com>

RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y vim.tiny gnupg wget net-tools ca-certificates unzip apt-transport-https \
 && rm -rf /var/lib/apt/lists/*

ADD include/env_secrets_expand.sh /usr/local/bin/

# From https://github.com/ncopa/su-exec
ADD include/su-exec.c /tmp/

RUN apt-get update && apt-get install build-essential -y && \
  gcc -Wall -Werror -g -o /usr/local/bin/su-exec /tmp/su-exec.c && \
  chmod +x /usr/local/bin/su-exec && \
  apt-get --purge remove build-essential -y && \
  apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*


