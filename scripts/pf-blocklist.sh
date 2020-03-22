#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pf-blocklist.sh
#
# Downloads IP addresses and ranges for blocking with PF:
#   1) Published lists of ad/malware hosts
#   2) Organizational Autonomous System (AS) assignments
#      (Requires https://github.com/drduh/config/tree/master/asns/*)
#   3) Country AS assignments
#      (Requires https://github.com/drduh/config/tree/master/zones)

#set -x

dns=1.1.1.1
custom=pf-custom.$(date +%F)
threats=pf-threats.$(date +%F)
zones=pf-zones.$(date +%F)
blocklist=pf-blocklist.$(date +%F)
doas whoami >/dev/null || exit 1

printf "Current rules: "
doas pfctl -t blocklist -T show | wc -l

action=""
while [[ -z "${action}" ]] ;
  do read -n 1 -p "Continue? (y/n) " action
done
printf "\n"

if [[ "${action}" =~ ^([yY])$ ]] ; then
  rm $custom $threats $zones $blocklist 2>/dev/null
  touch $custom $threats $zones

  printf "Checking threats ..."
  curl -sq \
    "https://pgl.yoyo.org/adservers/iplist.php?ipformat=&showintro=0&mimetype=plaintext" \
    "https://www.binarydefense.com/banlist.txt" \
    "https://rules.emergingthreats.net/blockrules/compromised-ips.txt" \
    "https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt" \
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset" \
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset" \
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level3.netset" \
    "https://isc.sans.edu/api/threatlist/shodan/shodan.txt" | \
  grep -Ev "^192\.168\.|^10\.|172\.16\.|127\.0\.0\.0|0\.0\.0\.0|^#|#$" | \
  grep -E "^[0-9]" >> $threats
  wc -l $threats

  # http://www.bgplookingglass.com/list-of-autonomous-system-numbers
  # https://github.com/drduh/config/tree/master/asns/*
  printf "Checking asns ..."
  for asn in $(find asns -type f) ; do
    printf "# $asn\n" >> $custom
    for nb in $(grep -v "^#" $asn) ; do
      printf " $nb"
      whois -h whois.radb.net !g$nb | tr " " "\n" | \
        grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]+" >> $custom
    done
  done
  wc -l $custom

  # https://www.abuseat.org/public/country.html
  # https://github.com/drduh/config/tree/master/zones
  printf "Checking zones ..."
  for zone in $(grep -v "^#" zones | sed "s/\ \ \#.*//g") ; do
    printf " $zone"
    curl -sq \
      "https://www.ipdeny.com/ipblocks/data/countries/$zone.zone" >> $zones
  done
  wc -l $zones

  sort $custom $threats $zones | uniq > $blocklist
  wc -l $blocklist

  if [[ ! -s $blocklist ]] ; then
    printf "Error: empty blocklist\n" ; exit 1
  fi

  doas cp -v /etc/pf/blocklist /etc/pf/blocklist.$(date +%F) && \
    doas cp -v ./$blocklist /etc/pf/blocklist
  doas pfctl -f /etc/pf.conf
  printf "\nnew rules: "
  doas pfctl -t blocklist -T show | wc -l

else
  printf "\ntesting blocked sites ...\n"
  for ws in $(/bin/ls asns/) ; do
    printf "$ws.com: "
    curl -v \
      https://$(dig a $ws.com @$dns +short|head -n1) 2>&1 | \
        grep "Permission denied" || printf "BLOCK FAILED"
  done
fi
