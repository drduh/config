#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/pf-blocklist.sh
# Generates IP sets for autonomous systems and from published blocklists.
# Facebook (AS32934)
# Apple (AS714)
# Microsoft (AS8075)
# DoD (AS721)
# Twitter (AS13414)
rm ./pf-custom 2>/dev/null ; touch pf-custom
for nb in AS32934 AS714 AS8075 AS721 AS13414 ; do
  whois -h whois.radb.net !g$nb | \
  tr " " "\n" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}.+' | \
  sort | uniq >> pf-custom
done
wc -l pf-custom
rm ./pf-threats 2>/dev/null ; touch pf-threats
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
sort | uniq >> pf-threats
wc -l pf-threats
cat pf-custom pf-threats > pf-blacklist
