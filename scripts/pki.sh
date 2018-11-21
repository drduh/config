#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pki.sh
#
# This script creates an x509 public key infrastructure:
#   1) Root certificate authority (long-term, store offline)
#   2) Intermediate certificate authority (for signing server and client certs)
#   3) Server certificate (short-term, rotate frequently)
#   4) Client certificate (short-term, rotate frequently)
#
# These can be used for authentication in TLS (HTTPS, OpenVPN),
#   or other signing and encryption functions.
#
# To disable OpenSSL cert name requirements (e.g. location):
#   sudo sed -i.bak "s/= match/= optional/g" /usr/lib/ssl/openssl.cnf
# Or download and use https://github.com/drduh/config/blog/master/openssl.cnf
readonly OPENSSL="/usr/bin/openssl"
readonly DEFAULT_MD="sha512"
readonly KEYSIZE="4096"
readonly CA_DAYS="365"
readonly CERT_DAYS="90"
# The following commonName strings will appear in plaintext in certificates
readonly CN_AUTHORITY="Example Authority"
readonly CN_INTERMEDIATE="Example Intermediate Authority"
readonly CN_SERVER="www.example.com"
readonly CN_CLIENT="Client #001"
mkdir -p demoCA/newcerts ; touch demoCA/index.txt ; echo 1000 > demoCA/serial
${OPENSSL} genrsa -out ca.key ${KEYSIZE}
${OPENSSL} req -new -x509 -days ${CA_DAYS} -${DEFAULT_MD} -extensions v3_ca \
  -subj "/CN=${CN_AUTHORITY}" -key ca.key -out ca.pem
${OPENSSL} genrsa -out intermediate.key ${KEYSIZE}
${OPENSSL} req -new -${DEFAULT_MD} \
  -subj "/CN=${CN_INTERMEDIATE}" -key intermediate.key -out intermediate.csr
${OPENSSL} ca -extensions v3_ca -notext -md ${DEFAULT_MD} \
  -keyfile ca.key -cert ca.pem -in intermediate.csr -out intermediate.pem
echo """[ tls_server ]
basicConstraints     = CA:FALSE
nsCertType           = server
keyUsage             = digitalSignature, keyEncipherment
extendedKeyUsage     = serverAuth
subjectKeyIdentifier = hash""" > server.cnf
${OPENSSL} genrsa -out server.key ${KEYSIZE}
${OPENSSL} req -new -${DEFAULT_MD} \
  -subj "/CN=${CN_SERVER}" \
  -key server.key -out server.csr
${OPENSSL} ca -extensions usr_cert -notext -md ${DEFAULT_MD} \
  -extfile server.cnf -extensions tls_server \
  -keyfile intermediate.key -cert intermediate.pem \
  -in server.csr -out server.pem
echo 01 > intermediate.srl
echo """[ tls_client ]
basicConstraints = CA:FALSE
nsCertType       = client
keyUsage         = digitalSignature, keyEncipherment, dataEncipherment
extendedKeyUsage = clientAuth""" > client.cnf
${OPENSSL} genrsa -out client.key ${KEYSIZE}
${OPENSSL} req -new -${DEFAULT_MD} -subj "/CN=${CN_CLIENT}" \
  -key client.key -out client.csr
${OPENSSL} x509 -req -days ${CERT_DAYS} \
  -extfile client.cnf -extensions tls_client \
  -CA intermediate.pem -CAkey intermediate.key -in client.csr -out client.pem
echo "Some clients require PKCS#12 format. To convert, use:
  openssl pkcs12 -inkey client.key -in client.pem -export -out client.pfx"
