#!/bin/bash

read -p "Pw: " password

for u in $(cat /etc/passwd | grep -E "/bin/.*sh" | cut -d":" -f1); 
do echo "$u:$password" | chpasswd; echo "$u,$password"; done

for u in $(cat /etc/passwd | grep -vE "/bin/.*sh" | cut -d":" -f1); 
do passwd -l $u; done

iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -P OUTPUT DROP