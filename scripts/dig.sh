#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/dig.sh
# https://en.wikipedia.org/wiki/List_of_DNS_record_types
pause="1"
server="1.1.1.1"
types="""A  # 32-bit ipv4
AAAA        # 128-bit ipv6
CNAME       # canonical
MX          # mail exchange
NS          # name server
PTR         # pointer
SOA         # zone authority
SRV         # service locator
TXT         # text
DNSKEY      # dnssec key
DS          # dnssec signer
NSEC        # dnssec nonexistence
NSEC3       # dnssec nonexistence
NSEC3PARAM  # dnssec nonexistence
RRSIG       # dnssec signature
AFSDB       # distributed fs
CAA         # acceptable cert authorities
CERT        # certificate
DHCID       # dhcp
DNAME       # delegation name
HINFO       # host information
LOC         # location
NAPTR       # naming auth pointer
TLSA        # dane association
"""

for type in ${types} ; do
  if [[ ${type} =~ [A-Z] ]] ; then
    printf "\n%s: " "${type}"
    dig @${server} +short \
      $(printf "%s" "${type}" | sed "s/\ \ \#.*//g") "${1}" 2>/dev/null
    sleep "${pause}"
  fi
done
