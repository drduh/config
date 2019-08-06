#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pki.sh
# https://tools.ietf.org/html/rfc5280
readonly OPENSSL="/usr/bin/openssl"
readonly DEFAULT_MD="sha512"
readonly KEYSIZE="4096"
readonly CA_DAYS="300"
readonly CERT_DAYS="8"
readonly CN_AUTHORITY=$(tr -dc '[:xdigit:]' < /dev/urandom | fold -w 10 | head -n1)
readonly CN_SERVER=$(tr -dc '[:xdigit:]' < /dev/urandom | fold -w 10 | head -n1)
readonly CN_CLIENT=$(tr -dc '[:xdigit:]' < /dev/urandom | fold -w 10 | head -n1)
#rm -rf demoCA ca.* client.* server.*
mkdir -p demoCA/newcerts
touch demoCA/index.txt
echo """[ tls_client ]
basicConstraints = CA:FALSE
nsCertType       = client
keyUsage         = digitalSignature, keyEncipherment, dataEncipherment
extendedKeyUsage = clientAuth
[ tls_server ]
basicConstraints     = CA:FALSE
nsCertType           = server
keyUsage             = digitalSignature, keyEncipherment
extendedKeyUsage     = serverAuth
subjectKeyIdentifier = hash""" > ext.cnf
${OPENSSL} genrsa -out ca.key ${KEYSIZE}
${OPENSSL} genrsa -out client.key ${KEYSIZE}
${OPENSSL} genrsa -out server.key ${KEYSIZE}
${OPENSSL} req -new -x509 -days ${CA_DAYS} -${DEFAULT_MD} -subj "/CN=${CN_AUTHORITY}" -config openssl.cnf -extensions v3_ca -key ca.key -out ca.pem -set_serial 0x$(openssl rand -hex 32)
${OPENSSL} req -new -${DEFAULT_MD} -subj "/CN=${CN_CLIENT}" -key client.key -out client.csr
${OPENSSL} req -new -${DEFAULT_MD} -subj "/CN=${CN_SERVER}" -key server.key -out server.csr
${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} -extfile ext.cnf -extensions tls_client -CA ca.pem -CAkey ca.key -in client.csr -out client.pem -set_serial 0x$(openssl rand -hex 32)
${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} -extfile ext.cnf -extensions tls_server -CA ca.pem -CAkey ca.key -in server.csr -out server.pem -set_serial 0x$(openssl rand -hex 32)
