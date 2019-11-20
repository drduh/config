#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pf-blocklist.sh
#
# Downloads and blocks IP addresses with PF from three categories:
#   1) Published lists of ad/malware hosts
#   2) Autonomous System assignments to orgs and corps
#      (Requires https://github.com/drduh/config/tree/master/asns)
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
#   linkedin.com: * Immediate connect fail for 108.xxx: Permission denied
#   microsoft.com: * Immediate connect fail for 40.xxx: Permission denied
#   myspace.com: * Immediate connect fail for 63.xxx Permission denied
#   twitter.com: * Immediate connect fail for 104.xxx: Permission denied

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
  for nb in $(cat asns/* | tr "\n" " "); do
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
  printf "testing blocked sites ...\n"
  for ws in $(/bin/ls asns/) ; do
    printf "$ws.com: "
    curl -v \
      https://$(dig a $ws.com @1.1.1.1 +short|head -n1) 2>&1 | \
        grep "Permission denied" || printf "BLOCK FAILED"
  done
fi
