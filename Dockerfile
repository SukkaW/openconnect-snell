FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx
FROM --platform=$BUILDPLATFORM frolvlad/alpine-glibc:latest AS build

LABEL maintainer="SukkaW <hi@skk.moe>"

ARG SNELL_VERSION=4.0.1
ARG TARGETPLATFORM

COPY --from=xx / /
COPY get-snell-url.sh /get-snell-url.sh

RUN xx-info env \
  && wget -O snell-server.zip $(/get-snell-url.sh ${SNELL_VERSION} $(xx-info arch)) \
  && unzip snell-server.zip \
  && rm snell-server.zip \
  && xx-verify /snell-server

FROM frolvlad/alpine-glibc:latest

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
ENV VPN_NO_DTLS=

RUN apk add --update --no-cache openconnect
COPY --from=build /snell-server /usr/bin/snell-server
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
