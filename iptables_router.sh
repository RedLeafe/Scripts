#!/bin/bash

# Run iptables commands
sudo iptables -t nat -A PREROUTING -d 172.18.13.13 -p tcp --dport 80 -j DNAT --to-destination 192.168.13.5:80
sudo iptables -t nat -A PREROUTING -d 172.18.13.13 -p tcp --dport 443 -j DNAT --to-destination 192.168.13.5:443
sudo iptables -t nat -A PREROUTING -d 172.18.13.13 -p udp --dport 53 -j DNAT --to-destination 192.168.13.12:53
sudo iptables -t nat -A PREROUTING -d 172.18.13.13 -p tcp --dport 53 -j DNAT --to-destination 192.168.13.12:53
sudo iptables -t nat -A PREROUTING -d 172.18.13.13 -p tcp --dport 5432 -j DNAT --to-destination 192.168.13.7:5432
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
