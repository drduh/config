#!/usr/bin/env bash
# https://github.com/drduh/config/blob/main/scripts/pki.sh
# https://tools.ietf.org/html/rfc5280
# Generates RSA PKI with root, server and client certificates

#set -x # uncomment to debug
set -o errtrace
set -o nounset
set -o pipefail

umask 077

# Directory to save output materials
readonly MATS="pki"

# Path to openssl binary
#readonly OPENSSL="/opt/homebrew/bin/openssl"
readonly OPENSSL="/usr/bin/openssl"

# Path to openssl configuration
readonly OPENSSL_CONF="./openssl.cnf"

# Days to self-sign CA for (1 year - 15 days)
readonly CA_DAYS="350"

# Days to sign leaf certificates
readonly CERT_DAYS="90"

# Key size (RSA)
readonly KEYSIZE="4096"

# Signing algo
readonly DEFAULT_MD="sha384"

# Serial number size (in bytes)
readonly SERIAL_SIZE=32

if [[ ! -x ${OPENSSL} ]] ; then
  printf "need ${OPENSSL}\n" ; exit 1
fi

if [[ ! -f ${OPENSSL_CONF} ]] ; then
  printf "need ${OPENSSL_CONF}\n" ; exit 1
fi

fail () {
  # Print an error in red and exit.
  tput setaf 1 ; printf "\nERROR: %s\n" "${1}" ; tput sgr0
  exit 1
}

# Generate random common name strings or set custom ones
readonly RAND_FUNC="$(LC_ALL=C tr -dc '[:upper:]' < /dev/urandom | fold -w 6 | head -1)"
for cn in CA SERVER CLIENT ; do
  export ${cn}="${cn}-${RAND_FUNC}"
  #CA="My CA"
  #SERVER="My Server"
  #CLIENT="My Client"
done

# Prepare output directory
mkdir -p ${MATS} >/dev/null

# Generate keys
for key in ca server client ; do
  if [[ ! -f "${MATS}/${key}.key" ]] ; then
    ${OPENSSL} genrsa -out ${MATS}/${key}.key ${KEYSIZE}
  fi
done

# Self-sign authority certificate
${OPENSSL} req -new -x509 -days ${CA_DAYS} -${DEFAULT_MD} \
  -subj "/CN=${CA}" \
  -config ${OPENSSL_CONF} -extensions v3_ca \
  -set_serial "0x$(${OPENSSL} rand -hex ${SERIAL_SIZE})" \
  -key ${MATS}/ca.key -out ${MATS}/ca.pem || \
    fail "failed to sign certificate authority"

# Create server request
${OPENSSL} req -new -${DEFAULT_MD} -subj "/CN=${SERVER}" \
  -key ${MATS}/server.key -out ${MATS}/server.csr

# Sign server certificate
${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} \
  -extfile ${OPENSSL_CONF} -extensions tls_server \
  -set_serial "0x$(${OPENSSL} rand -hex ${SERIAL_SIZE})" \
  -CA ${MATS}/ca.pem -CAkey ${MATS}/ca.key \
  -in ${MATS}/server.csr -out ${MATS}/server.pem 2>/dev/null

# Create client request
${OPENSSL} req -new -${DEFAULT_MD} -subj "/CN=${CLIENT}" \
  -key ${MATS}/client.key -out ${MATS}/client.csr

# Sign client certiicate
${OPENSSL} x509 -req -days ${CERT_DAYS} -${DEFAULT_MD} \
  -extfile ${OPENSSL_CONF} -extensions tls_client \
  -set_serial "0x$(${OPENSSL} rand -hex ${SERIAL_SIZE})" \
  -CA ${MATS}/ca.pem -CAkey ${MATS}/ca.key \
  -in ${MATS}/client.csr -out ${MATS}/client.pem 2>/dev/null

# Print materials
for cert in ca server client ; do
  printf "\n**** %s ****\n" "${cert}"
  ${OPENSSL} x509 -subject -issuer -enddate -serial \
    -fingerprint -sha256 -noout -in ${MATS}/${cert}.pem
  printf "*%.0s" {1..16}
done

