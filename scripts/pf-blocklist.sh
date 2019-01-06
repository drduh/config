#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pf-blocklist.sh
custom=pf-custom.$(date +%F)
threats=pf-threats.$(date +%F)
zones=pf-zones.$(date +%F)
blocklist=pf-blocklist.$(date +%F)

doas whoami

printf "current rules: "
doas pfctl -t blocklist -T show | wc -l
action=""
while [[ -z "${action}" ]] ;
  do read -n 1 -p "Continue? (y/n) " action
done
printf "\n"
if [[ "${action}" =~ ^([yY])$ ]] ; then
  doas rm $custom $threats $zones $blocklist 2>/dev/null

  curl -sq \
    https://www.binarydefense.com/banlist.txt \
    https://rules.emergingthreats.net/blockrules/compromised-ips.txt \
    https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt \
    https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level{1..3}.netset \
    https://isc.sans.edu/api/threatlist/shodan/shodan.txt | \
  grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | \
  grep -Ev "192.168.0.0|10.0.0.0|172.16.0.0|127.0.0.0|0.0.0.0" > $threats
  wc -l $threats

  # Apple (AS714)
  # Facebook (AS32934)
  # Microsoft (AS8075)
  # Twitter (AS13414)
  # DoD (AS721)
  # Note this returns blocks of addresses - not individual IPs!
  rm $custom ; touch $custom
  for nb in AS714 AS32934 AS8075 AS13414 AS721 ; do
    whois -h whois.radb.net !g$nb | \
    tr " " "\n" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}.+' | \
    sort | uniq >> $custom
  done
  wc -l $custom

  touch $zones
  for zn in ae af az bd cd cg cn eg gh ht iq ir jo ke kw kz lr ly me mk mn mv mx na ne ng ni nr pk pl pr qa ru rw sa sd sr sy td tj tn tr tt ua ug uz ve ye zm ; do
    curl -sq \
      http://www.ipdeny.com/ipblocks/data/countries/$zn.zone >> $zones
  done
  wc -l $zones

  sort $threats $custom $zones | uniq > $blocklist
  wc -l $blocklist

  doas cp -v /etc/pf/blocklist /etc/pf/blocklist.$(date +%F)
  doas cp -v $blocklist /etc/pf/blocklist
  doas pfctl -d ; doas pfctl -e -f /etc/pf.conf

  printf "new rules: "
  doas pfctl -t blocklist -T show | wc -l
else
  printf "testing blocked sites ..."
  for ws in apple.com facebook.com microsoft.com twitter.com ; do
    printf "\n$ws: "
    curl -v \
      https://$(dig a $ws @1.1.1.1 +short | head -n1) 2>&1 | grep "Permission denied" || printf "BLOCK FAILED"
  done
fi

