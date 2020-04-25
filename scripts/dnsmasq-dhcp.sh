#!/bin/sh
# https://github.com/drduh/config/blob/master/scripts/dnsmasq-dhcp.sh
touch /var/log/dnsmasq-dhcp
echo "$(date) -- ${1} ${2} ${3} ${4}" >> /var/log/dnsmasq-dhcp
