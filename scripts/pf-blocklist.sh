#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pf-blocklist.sh
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
sort | uniq > pf-threats
wc -l pf-threats
