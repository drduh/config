#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pf-blocklist.sh
# Generates IP sets for autonomous systems and from published blocklists.
# Apple (AS714)
# Facebook (AS32934)
# Microsoft (AS8075)
# Twitter (AS13414)
# DoD (AS721)
custom=pf-custom-rules.$(date +%F)
threats=pf-threats.$(date +%F)
blocklist=pf-blocklist.$(date +%F)
rm $custom $threats $blocklist 2>/dev/null
for nb in AS32934 AS714 AS8075 AS721 AS13414 ; do
  whois -h whois.radb.net !g$nb | \
  tr " " "\n" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}.+' | \
  sort | uniq >> $custom
done
wc -l $custom
curl -sq \
  https://www.binarydefense.com/banlist.txt \
  https://rules.emergingthreats.net/blockrules/compromised-ips.txt \
  https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt \
  https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level3.netset \
  https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset \
  https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset \
  https://isc.sans.edu/api/threatlist/shodan/shodan.txt | \
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | \
grep -Ev "192.168.0.0|10.0.0.0|172.16.0.0|127.0.0.0|0.0.0.0" | \
sort | uniq > $threats
wc -l $threats
cat $threats $custom | sort | uniq > $blocklist
doas cp -v /etc/pf/blocklist /etc/pf/blocklist.old
doas cp -v ./pf-blocklist /etc/pf/blocklist
doas pfctl -d ; doas pfctl -e -f /etc/pf.conf
doas pfctl -t blocklist -T show | wc -l
for s in apple.com facebook.com microsoft.com twitter.com ; do
  curl -vv https://$(dig a $s @1.1.1.1 +short|head -n1) 2>&1|grep "Permission denied"
done
