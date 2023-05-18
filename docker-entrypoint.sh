#!/bin/sh

launch() {
  if [ -z "$SNELL_PSK" ]; then
    SNELL_PSK=`hexdump -n 16 -e '4/4 "%08x" 1 "\n"' /dev/urandom`
  fi

  openconnect -V
  snell-server -v

  cat > snell.conf <<EOF
[snell-server]
listen = ${SNELL_HOST}:${SNELL_PORT}
psk = ${SNELL_PSK}
obfs = ${SNELL_OBFS}
EOF

  cat snell.conf

  if [ -z "$VPN_NO_DTLS" ]; then
    (echo "${VPN_PASSWORD}"; echo "${VPN_AUTH_CODE}") | openconnect --user="${VPN_USER}" --passwd-on-stdin --servercert="${VPN_SERVERCERT}" --authgroup="${VPN_AUTH_GROUP}" --os=linux-64 "${VPN_HOST}" &
  else
    (echo "${VPN_PASSWORD}"; echo "${VPN_AUTH_CODE}") | openconnect --user="${VPN_USER}" --passwd-on-stdin --servercert="${VPN_SERVERCERT}" --authgroup="${VPN_AUTH_GROUP}" --os=linux-64 --no-dtls "${VPN_HOST}" &
  fi

  # Wait for 5 seconds before starting snell-server, to make sure OpenConnect is up and populated
  sleep 5
  snell-server -c snell.conf &

  # Wait for any process to exit
  wait -n
  # Exit with status of process that exited first
  exit $?
}

if [ -z "$@" ]; then
  launch
else
  exec "$@"
fi
