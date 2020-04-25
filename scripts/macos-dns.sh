#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/macos-dns.sh
sudo scutil << EOF
get State:/Network/Service/gpd.pan/DNS
d.remove SearchDomains
d.remove ServerAddress
d.add ServerAddresses * 127.0.0.1 ::1
set State:/Network/Service/gpd.pan/DNS
exit
EOF
