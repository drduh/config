#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/dnscrypt.sh
rm -vf 0.crt 0.key public.key secret.key
pkill dnscrypt-wrapper
dnscrypt-wrapper --gen-provider-keypair --provider-name=abc.xyz \
  --ext-address=$(curl -s https://icanhazip.com/) 2>/dev/null | grep sdns
dnscrypt-wrapper --gen-crypt-keypair --crypt-secretkey-file=0.key >/dev/null
dnscrypt-wrapper --gen-cert-file \
  --crypt-secretkey-file=0.key --provider-cert-file=0.crt \
  --provider-publickey-file=public.key \
  --provider-secretkey-file=secret.key --cert-file-expire-days=30 >/dev/null
sleep 1
dnscrypt-wrapper --resolver-address=127.0.0.1:53 \
  --listen-address=0.0.0.0:443 --provider-name=abc.xyz \
  --crypt-secretkey-file=0.key --provider-cert-file=0.crt -V
