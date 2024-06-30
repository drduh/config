#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pki.sh
# https://tools.ietf.org/html/rfc5280
#set -x # uncomment to debug
set -o errtrace
set -o nounset
set -o pipefail

umask 077

readonly OPENSSL="/usr/bin/openssl"
readonly OPENSSL_CONF="./openssl.cnf"
readonly CA_DAYS="3653"
readonly CERT_DAYS="90"
readonly DEFAULT_MD="sha512"
readonly KEYSIZE="4096"

if [[ ! -x ${OPENSSL} ]] ; then
  printf "need ${OPENSSL}\n" ; exit 1
fi

if [[ ! -f ${OPENSSL_CONF} ]] ; then
  printf "need ${OPENSSL_CONF}\n" ; exit 1
fi

for name in CN_AUTHORITY CN_SERVER CN_CLIENT ; do
  readonly $name="$(tr -dc '[:xdigit:]' < /dev/urandom | fold -w 10 | head -n1)"
done

for key in ca client server ; do
  ${OPENSSL} genrsa -out $key.key ${KEYSIZE}
done

${OPENSSL} req -new -x509 -days ${CA_DAYS} -${DEFAULT_MD} \
  -subj "/CN=${CN_AUTHORITY}" \
  -config ${OPENSSL_CONF} -extensions v3_ca \
  -set_serial "0x$(${OPENSSL} rand -hex 32)" \
  -key ca.key -out ca.pem

${OPENSSL} req -new -${DEFAULT_MD} \
  -subj "/CN=${CN_SERVER}" \
  -key server.key -out server.csr

${OPENSSL} req -new -${DEFAULT_MD} \
  -subj "/CN=${CN_CLIENT}" \
  -key client.key -out client.csr

${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} \
  -extfile ${OPENSSL_CONF} -extensions tls_server \
  -CA ca.pem -CAkey ca.key \
  -set_serial "0x$(${OPENSSL} rand -hex 32)" \
  -in server.csr -out server.pem

${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} \
  -extfile ${OPENSSL_CONF} -extensions tls_client \
  -CA ca.pem -CAkey ca.key \
  -set_serial "0x$(${OPENSSL} rand -hex 32)" \
  -in client.csr -out client.pem

#${OPENSSL} pkcs12 -inkey client.key -in client.pem \
#  -export -out client.pfx
