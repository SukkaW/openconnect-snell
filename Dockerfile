FROM debian:stable-slim

LABEL maintainer="SukkaW <hi@skk.moe>"

RUN apt-get update \
  && apt-get install -y unzip wget openconnect \
  && wget -O snell-server.zip https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip \
  && unzip snell-server.zip \
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

COPY docker-entrypoint.sh /opt
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
