#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pki.sh
# https://tools.ietf.org/html/rfc5280

set -o errtrace
set -o nounset
set -o pipefail

#set -x # uncomment to debug

umask 077

if [[ ! -f "openssl.cnf" ]] ; then
  printf "need config/openssl.cnf\n"
  exit 1
fi

readonly OPENSSL="/usr/bin/openssl"
readonly DEFAULT_MD="sha512"
readonly KEYSIZE="4096"
readonly CA_DAYS="1000"
readonly CERT_DAYS="100"
readonly CN_AUTHORITY=$(tr -dc '[:xdigit:]' < /dev/urandom | fold -w 10 | head -n1)
readonly CN_SERVER=$(tr -dc '[:xdigit:]' < /dev/urandom | fold -w 10 | head -n1)
readonly CN_CLIENT=$(tr -dc '[:xdigit:]' < /dev/urandom | fold -w 10 | head -n1)

for key in ca client server ; do
  ${OPENSSL} genrsa -out $key.key ${KEYSIZE}
done

${OPENSSL} req -new -x509 -days ${CA_DAYS} -${DEFAULT_MD} \
  -subj "/CN=${CN_AUTHORITY}" \
  -config openssl.cnf -extensions v3_ca \
  -set_serial "0x$(${OPENSSL} rand -hex 32)" \
  -key ca.key -out ca.pem

${OPENSSL} req -new -${DEFAULT_MD} \
  -subj "/CN=${CN_SERVER}" \
  -key server.key -out server.csr

${OPENSSL} req -new -${DEFAULT_MD} \
  -subj "/CN=${CN_CLIENT}" \
  -key client.key -out client.csr

${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} \
  -extfile openssl.cnf -extensions tls_server \
  -CA ca.pem -CAkey ca.key \
  -set_serial "0x$(${OPENSSL} rand -hex 32)" \
  -in server.csr -out server.pem

${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} \
  -extfile openssl.cnf -extensions tls_client \
  -CA ca.pem -CAkey ca.key \
  -set_serial "0x$(${OPENSSL} rand -hex 32)" \
  -in client.csr -out client.pem

#openssl pkcs12 -inkey client.key -in client.pem -export -out client.pfx
