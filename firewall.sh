#!/bin/bash

PATH='/sbin'

EXT=eth0
INT=eth1
DMZ=eth2
WIFI=wlan0

INT_NET=172.16.1.0/24
DMZ_NET=10.8.4.0/24
WIFI_NET=192.168.1.0/24

echo "Flush rules"
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X
iptables -Z

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

echo "Allow loopback"
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

echo "Drop invalid states"
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A OUTPUT -m conntrack --ctstate INVALID -j DROP
iptables -A FORWARD -m conntrack --ctstate INVALID -j DROP

echo "Allow established, related and ICMP echo packets"
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

echo "Allow DHCP"
iptables -I INPUT -i $DMZ -p udp -m udp --dport 67 -m conntrack --ctstate NEW -j ACCEPT
iptables -I INPUT -i $INT -p udp -m udp --dport 67 -m conntrack --ctstate NEW -j ACCEPT
iptables -I INPUT -i $WIFI -p udp -m udp --dport 67 -m conntrack --ctstate NEW -j ACCEPT

echo "Allow SSH from local Ethernet"
iptables -A INPUT -i $INT -s $INT_NET -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT

echo "Allow DNS (TCP and UDP)"
iptables -A INPUT -i $INT -s $INT_NET -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $INT -s $INT_NET -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $DMZ -s $DMZ_NET -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $DMZ -s $DMZ_NET -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $WIFI -s $WIFI_NET -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $WIFI -s $WIFI_NET -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT

echo "Add transparent Privoxy forwarding"
iptables -A INPUT -i $INT -s $INT_NET -p tcp --dport 8118 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -A PREROUTING -i $INT -p tcp --dport 80 -j DNAT --to-destination 10.8.1.1:8118
iptables -A INPUT -i $DMZ -s $DMZ_NET -p tcp --dport 8118 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -A PREROUTING -i $DMZ -p tcp --dport 80 -j DNAT --to-destination 172.16.1.1:8118
iptables -A INPUT -i $WIFI -s $WIFI_NET -p tcp --dport 8118 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -A PREROUTING -i $WIFI -p tcp --dport 80 -j DNAT --to-destination 192.168.1.1:8118

echo "Example of blocking traffic by IP address"
iptables -A FORWARD -d 209.18.47.62 -j DROP

echo "Allow outgoing to Internet"
iptables -A OUTPUT -o $EXT -d 0.0.0.0/0 -j ACCEPT

echo "Allow traffic from the firewall to LAN"
iptables -A OUTPUT -o $INT -d $INT_NET -j ACCEPT
iptables -A OUTPUT -o $DMZ -d $DMZ_NET -j ACCEPT
iptables -A OUTPUT -o $WIFI -d $WIFI_NET -j ACCEPT

echo "Enable NAT"
iptables -t nat -A POSTROUTING -o $EXT -j MASQUERADE
iptables -A FORWARD -o $EXT -i $INT -s $INT_NET -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -o $EXT -i $DMZ -s $DMZ_NET -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -o $EXT -i $WIFI -s $WIFI_NET -m conntrack --ctstate NEW -j ACCEPT

echo "Mangle TTL"
iptables -t mangle -A POSTROUTING -j TTL --ttl-set 65

echo "Log dropped packets"
iptables -A INPUT -m limit --limit 1/sec -j LOG --log-level debug --log-prefix 'IN>'
iptables -A OUTPUT -m limit --limit 1/sec -j LOG --log-level debug --log-prefix 'OUT>'
iptables -A FORWARD -m limit --limit 1/sec -j LOG --log-level debug --log-prefix 'FWD>'
