#!/bin/bash

# Mincraft Firewall Setup script
# Made by RDProject Development Team
# For personal use

# Define variables
iptables=/sbin/iptables
port=25565
block_linux_connections=true
limit_global_connections=true
limit_global_connections_max=1
burstconns=50

# Create a new chain for SCANS
$iptables -N SCANS

# Drop suspicious TCP packets to protect against various types of scans and attacks
$iptables -A SCANS -p tcp --tcp-flags FIN,URG,PSH FIN,URG,PSH -j DROP
$iptables -A SCANS -p tcp --tcp-flags ALL ALL -j DROP
$iptables -A SCANS -p tcp --tcp-flags ALL NONE -j DROP
$iptables -A SCANS -p tcp --tcp-flags SYN,RST SYN,RST -j DROP

# Apply SCANS chain to INPUT
$iptables -A INPUT -j SCANS

# Drop fragmented packets
$iptables -A INPUT -f -j DROP

# Drop new TCP connections not using SYN
$iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

# Drop INVALID packets
$iptables -A INPUT -m state --state INVALID -j DROP
$iptables -A FORWARD -m state --state INVALID -j DROP
$iptables -A OUTPUT -m state --state INVALID -j DROP

# ICMP restrictions
$iptables -A INPUT -p icmp --icmp-type address-mask-request -j DROP
$iptables -A INPUT -p icmp --icmp-type timestamp-request -j DROP
$iptables -A INPUT -p icmp --icmp-type router-solicitation -j DROP
$iptables -A INPUT -p icmp -m limit --limit 2/second -j ACCEPT

# Rate limiting RST packets
$iptables -A INPUT -p tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT

# Portscan protection: block if recent scans detected
$iptables -A INPUT -m recent --name portscan --rcheck --seconds 86400 -j DROP
$iptables -A FORWARD -m recent --name portscan --rcheck --seconds 86400 -j DROP

# Protect the specified port (25565 in this case)
$iptables -A INPUT -p tcp --dport $port --tcp-option 8 --tcp-flags FIN,SYN,RST,ACK SYN -j REJECT --reject-with icmp-port-unreachable
$iptables -A INPUT -p tcp --dport $port -m state --state RELATED,ESTABLISHED -j ACCEPT

# Global connection limiting
if $limit_global_connections; then
    $iptables -I INPUT -p tcp --dport $port -m state --state NEW -m limit --limit $limit_global_connections_max/s -j ACCEPT
    $iptables -A INPUT -p tcp --dport $port -m state --state RELATED,ESTABLISHED -j ACCEPT
    $iptables -A INPUT -p tcp --dport $port --tcp-flags FIN,SYN,RST,ACK SYN -m connlimit --connlimit-above 150 --connlimit-mask 32 --connlimit-saddr -j DROP
    $iptables -A INPUT -p tcp --dport $port --tcp-flags FIN,SYN,RST,ACK SYN -m connlimit --connlimit-above 10 --connlimit-mask 32 --connlimit-saddr -j DROP
    echo 'Limited global connections!'
fi

# Block Linux connections if the option is set
if $block_linux_connections; then
    $iptables -A INPUT -p tcp -m tcp --syn --tcp-option 8 --dport $port -j REJECT
    echo 'Blocked Linux connections!'
fi

# Apply connection rate limiting
$iptables -A INPUT -p tcp --dport $port --syn -m limit --limit $burstconns/s -j ACCEPT
$iptables -A INPUT -p tcp --dport $port --syn -j DROP

# Persistent saving of iptables rules
apt-get install -y iptables-persistent
iptables-save > /etc/iptables/rules.v4

echo "(MFS) Firewall applied successfully."
