#!/bin/sh

launch() {
  if [ -z "$SNELL_PSK" ]; then
    SNELL_PSK=`hexdump -n 16 -e '4/4 "%08x" 1 "\n"' /dev/urandom`
  fi

  echo "snell psk: ${SNELL_PSK}"
  echo "snell listen: ${SNELL_HOST}:${SNELL_PORT}"
  echo "snell obfs: ${SNELL_OBFS}"

  cat > snell.conf <<EOF
[snell-server]
listen = ${SNELL_HOST}:${SNELL_PORT}
psk = ${SNELL_PSK}
obfs = ${SNELL_OBFS}
EOF

  cat snell.conf
  snell-server -c snell.conf &

  (echo "$VPN_PASSWORD"; echo "${VPN_AUTH_CODE}") | openconnect --user="${VPN_USER}" --passwd-on-stdin --servercert="${VPN_CERT_SHA256}" --authgroup="${VPN_AUTH_GROUP}" --os=linux-64 --passwd-on-stdin --no-dtls "${VPN_HOST}"
}

if [ -z "$@" ]; then
  launch
else
  exec "$@"
fi