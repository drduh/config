#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pf-blocklist.sh
#
# Downloads and blocks IP addresses with PF from three categories:
#   1) Published lists of ad/malware hosts
#   2) Autonomous System assignments to orgs and corps
#   3) Country assignments
#
# Example output:
#
#   $ doas ./pf-blocklist.sh
#   current rules:    86177
#   Continue? (y/n) y
#      68762 pf-threats.2019-01-21
#       2586 pf-custom.2019-01-21
#      33251 pf-zones.2019-01-21
#      96163 pf-blocklist.2019-01-21
#   /etc/pf/blocklist -> /etc/pf/blocklist.2019-01-21
#   pf-blocklist.2019-01-21 -> /etc/pf/blocklist
#   pf disabled
#   pf enabled
#   new rules:    96163
#
# Example successful test output:
#
#   $ doas ./pf-blocklist.sh
#   current rules:    96163
#   Continue? (y/n) n
#   testing blocked sites ...
#   apple.com: * Immediate connect fail for 17.xxx: Permission denied
#   facebook.com: * Immediate connect fail for 157.xxx: Permission denied
#   microsoft.com: * Immediate connect fail for 40.xxx: Permission denied
#   twitter.com: * Immediate connect fail for 104.xxx: Permission denied
#
custom=pf-custom.$(date +%F)
threats=pf-threats.$(date +%F)
zones=pf-zones.$(date +%F)
blocklist=pf-blocklist.$(date +%F)
doas whoami >/dev/null && echo "have permission"

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
    "https://pgl.yoyo.org/adservers/iplist.php?ipformat=&showintro=0&mimetype=plaintext" \
    https://www.binarydefense.com/banlist.txt \
    https://rules.emergingthreats.net/blockrules/compromised-ips.txt \
    https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt \
    https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level{1..3}.netset \
    https://isc.sans.edu/api/threatlist/shodan/shodan.txt | \
  grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | \
  grep -Ev "192.168.0.0|10.0.0.0|172.16.0.0|127.0.0.0|0.0.0.0" > $threats
  wc -l $threats

  # http://www.bgplookingglass.com/list-of-autonomous-system-numbers
  # radb returns blocks of addresses - not individual IPs
  touch $custom
  for nb in AS12076 AS13399 AS13414 AS13811 AS14413 AS14719 AS17345 AS20046 AS20049 AS20366 AS22692 AS23468 AS25796 AS26222 AS2709 AS30135 AS30575 AS31792 AS32476 AS32934 AS33739 AS3598 AS35995 AS36006 AS395496 AS395524 AS395851 AS396463 AS397466 AS40066 AS54888 AS5761 AS6182 AS6185 AS6194 AS6291 AS63293 AS63314 AS6584 AS714 AS8068 AS8069 AS8070 AS8071 AS8072 AS8073 AS8074 AS8075 ; do
    whois -h whois.radb.net !g$nb | \
    tr " " "\n" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}.+' | \
    sort | uniq >> $custom
  done
  wc -l $custom

  # https://www.abuseat.org/public/country.html
  touch $zones
  for zn in ae af az bd br cd cg cn dz eg gh ht id iq ir jo ke kw kz lr ly me mk mn mv mx na ne ng ni nr ph pk pr qa ru rw sa sd sr sy td tj tn tr tt ua ug uz ve vn ye zm ; do
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
