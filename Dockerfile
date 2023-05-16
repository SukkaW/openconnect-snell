FROM bitnami/minideb:latest

LABEL maintainer="SukkaW <hi@skk.moe>"

RUN install_packages unzip wget ca-certificates openconnect \
  && wget -O snell-server.zip https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip \
  && unzip snell-server.zip \
  && rm -rf snell-server.zip \
  && apt-get remove --purge -y unzip wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists /var/cache/apt/archives \
  && mv snell-server /usr/local/bin/

ENV SNELL_HOST=0.0.0.0
ENV SNELL_PORT=8388
ENV SNELL_PSK=
ENV SNELL_OBFS=off

EXPOSE ${SNELL_PORT}/tcp
EXPOSE ${SNELL_PORT}/udp

ENV VPN_USER=
ENV VPN_PASSWD=
ENV VPN_AUTH_GROUP=
ENV VPN_AUTH_CODE=
ENV VPN_HOST=
ENV VPN_SERVERCERT=

COPY docker-entrypoint.sh /opt
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
