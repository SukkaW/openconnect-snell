# openconnect-snell

[![Docker Pulls](https://img.shields.io/docker/pulls/sukka/openconnect-snell.svg)](https://hub.docker.com/r/sukka/openconnect-snell) [![Docker Stars](https://img.shields.io/docker/stars/sukka/openconnect-snell.svg)](https://hub.docker.com/r/sukka/openconnect-snell) [![Docker Automated build](https://img.shields.io/docker/automated/sukka/openconnect-snell.svg)](https://hub.docker.com/r/sukka/openconnect-snell)

Allow Surge to connect to OpenConnect by running OpenConnect and Snell Server (V4) inside a docker container.

```bash
docker pull sukka/openconnect-snell:latest
```

```bash
docker run -d \
  --privileged \
  -e VPN_USER= \
  -e VPN_PASSWORD= \
  -e VPN_AUTH_CODE= \
  -e VPN_AUTH_GROUP= \
  -e VPN_SERVERCERT= \
  -e VPN_HOST= \
  -e SNELL_OBFS=off \
  -p [Your Port]:8388 \
  --restart always \
  --name openconnect-snell sukka/openconnect-snell
```

```conf
[Proxy]
Proxy-Snell = snell, [Container IP], [Your Port], psk=password, version=4
```

## Configuration

- `SNELL_HOST`: Where the Snell Server will be listened at. Default is `0.0.0.0`.
- `SNELL_PORT`: Which Port that the Snell Server will be listened at. Default is `8388`.
- `SNELL_PSK`: Snell Server Pre-Shared Key. Will be generated automatically when not provided.
- `SNELL_OBFS`: Snell Server obfuscation mode. Default is `off`.

- `VPN_USER`: OpenConnect Username. Required.
- `VPN_PASSWD`: OpenConnect Password. Required.
- `VPN_HOST`: Where the OpenConnect will be connected to. Required.
- `VPN_SERVERCERT`: OpenConnect server certificate fingerprint to trust. Useful when the server configured certificate is untrusted. Optional.
- `VPN_AUTH_GROUP`: OpenConnect authentication group. Optional.
- `VPN_AUTH_CODE`: OpenConnect authentication code. Optional.
- `VPN_NO_DTLS`: Disable OpenConnect DTLS. Optional.

## License

[MIT](./LICENSE)

----

**openconnect-snell** © [Sukka](https://github.com/SukkaW), Released under the [MIT](./LICENSE) License.
Authored and maintained by Sukka with help from contributors ([list](https://github.com/SukkaW/openconnect-snell/graphs/contributors)).

> [Personal Website](https://skk.moe) · [Blog](https://blog.skk.moe) · GitHub [@SukkaW](https://github.com/SukkaW) · Telegram Channel [@SukkaChannel](https://t.me/SukkaChannel) · Mastodon [@sukka@acg.mn](https://acg.mn/@sukka) · Twitter [@isukkaw](https://twitter.com/isukkaw) · Keybase [@sukka](https://keybase.io/sukka)
