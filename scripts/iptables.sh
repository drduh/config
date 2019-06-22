#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/iptables.sh
PATH='/sbin'
EXT=enp1s0
INT=enp2s0
DMZ=enp3s0
#LAB=enp4s0
WIFI=wlp5s0
#EXT=eth0
#INT=eth1
#DMZ=eth2
#WIFI=wlan0
INT_NET=172.16.1.0/24
DMZ_NET=10.8.1.0/24
WIFI_NET=192.168.1.0/24
echo "Flushing rules"
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
echo "Allow established and related connections"
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
echo "Allow ping replies"
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
echo "Allow DHCP"
iptables -I INPUT -i $INT -p udp -m udp --dport 67 -m conntrack --ctstate NEW -j ACCEPT
iptables -I INPUT -i $DMZ -p udp -m udp --dport 67 -m conntrack --ctstate NEW -j ACCEPT
iptables -I INPUT -i $WIFI -p udp -m udp --dport 67 -m conntrack --ctstate NEW -j ACCEPT
#echo "Allow NTP"
#iptables -I INPUT -i $INT -p udp -m udp --dport 123 -m conntrack --ctstate NEW -j ACCEPT
#iptables -I INPUT -i $DMZ -p udp -m udp --dport 123 -m conntrack --ctstate NEW -j ACCEPT
#iptables -I INPUT -i $WIFI -p udp -m udp --dport 123 -m conntrack --ctstate NEW -j ACCEPT
echo "Allow SSH from local Ethernet"
iptables -A INPUT -i $INT -s $INT_NET -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
echo "Allow DNS (UDP and TCP for large replies)"
iptables -A INPUT -i $INT -s $INT_NET -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $INT -s $INT_NET -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $DMZ -s $DMZ_NET -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $DMZ -s $DMZ_NET -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $WIFI -s $WIFI_NET -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $WIFI -s $WIFI_NET -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
echo "Intercept HTTP traffic to Privoxy"
iptables -A INPUT -i $INT -s $INT_NET -p tcp --dport 8118 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $DMZ -s $DMZ_NET -p tcp --dport 8118 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -i $WIFI -s $WIFI_NET -p tcp --dport 8118 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -A PREROUTING -i $INT -p tcp --dport 80 -j DNAT --to-destination 10.8.1.1:8118
iptables -t nat -A PREROUTING -i $DMZ -p tcp --dport 80 -j DNAT --to-destination 172.16.1.1:8118
iptables -t nat -A PREROUTING -i $WIFI -p tcp --dport 80 -j DNAT --to-destination 192.168.1.1:8118
echo "Allow outgoing on external interface"
iptables -A OUTPUT -o $EXT -d 0.0.0.0/0 -j ACCEPT
echo "Allow traffic from the firewall to local networks"
iptables -A OUTPUT -o $INT -d $INT_NET -j ACCEPT
iptables -A OUTPUT -o $DMZ -d $DMZ_NET -j ACCEPT
iptables -A OUTPUT -o $WIFI -d $WIFI_NET -j ACCEPT
echo "Enable network address translation"
iptables -t nat -A POSTROUTING -o $EXT -j MASQUERADE
iptables -A FORWARD -o $EXT -i $INT -s $INT_NET -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -o $EXT -i $DMZ -s $DMZ_NET -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -o $EXT -i $WIFI -s $WIFI_NET -m conntrack --ctstate NEW -j ACCEPT
#iptables -t mangle -A POSTROUTING -j TTL --ttl-set 65
echo "Do not reply with Destination Unreachable messages"
iptables -A OUTPUT -p icmp --icmp-type destination-unreachable -j DROP
echo "Log all dropped packets"
iptables -A INPUT -m limit --limit 1/sec -j LOG --log-level debug --log-prefix 'DROPIN>'
iptables -A OUTPUT -m limit --limit 1/sec -j LOG --log-level debug --log-prefix 'DROPOUT>'
iptables -A FORWARD -m limit --limit 1/sec -j LOG --log-level debug --log-prefix 'DROPFWD>'
