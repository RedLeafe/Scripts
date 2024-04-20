#!/bin/bash

iptables -F
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT # allow loopback for testing and some issues
iptables -A INPUT -p tcp -m multiport --dports 53 -m conntrack --ctstate NEW -j ACCEPT
iptables -P INPUT DROP
iptables -P OUTPUT DROP
