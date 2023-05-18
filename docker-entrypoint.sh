#!/bin/sh

launch() {
  if [ -z "$SNELL_PSK" ]; then
    SNELL_PSK=`hexdump -n 16 -e '4/4 "%08x" 1 "\n"' /dev/urandom`
  fi

  cat > snell.conf <<EOF
[snell-server]
listen = ${SNELL_HOST}:${SNELL_PORT}
psk = ${SNELL_PSK}
obfs = ${SNELL_OBFS}
EOF

  cat snell.conf
  snell-server -c snell.conf &

  if [ -z "$VPN_NO_DTLS" ]; then
    (echo "${VPN_PASSWORD}"; echo "${VPN_AUTH_CODE}") | openconnect --user="${VPN_USER}" --passwd-on-stdin --servercert="${VPN_SERVERCERT}" --authgroup="${VPN_AUTH_GROUP}" --os=linux-64 "${VPN_HOST}"
  else
    (echo "${VPN_PASSWORD}"; echo "${VPN_AUTH_CODE}") | openconnect --user="${VPN_USER}" --passwd-on-stdin --servercert="${VPN_SERVERCERT}" --authgroup="${VPN_AUTH_GROUP}" --os=linux-64 --no-dtls "${VPN_HOST}"
  fi
}

if [ -z "$@" ]; then
  launch
else
  exec "$@"
fi
