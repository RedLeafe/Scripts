#!/bin/bash

read -p "Team Number: " team
read -p "Host Name: " name
read -p "How many times have you run this: " serial

localConfig=/etc/bind/named.conf.local

if [ ! -d /etc/bind/zones ]; then
	mkdir /etc/bind/zones
	cp /etc/bind/db.empty /etc/bind/zones/forward.ncaecybergames.org
	cp /etc/bind/db.empty /etc/bind/zones/reverse.ncaecybergames.org
	cp /etc/bind/db.empty /etc/bind/zones/forward.team.net
	cp /etc/bind/db.empty /etc/bind/zones/reverse.team.net
fi

cat << done > $localConfig
zone "ncaecybergames.org" IN {
	type master;
	file "/etc/bind/zones/forward.ncaecybergames.org";
};

zone "$team.168.192.in-addr.arpa" IN {
	tpye master;
	file "/etc/bind/zones/reverse.ncaecybergames.org";
};

zone "team$team.net" IN {
	type master;
	file "/etc/bind/zones/forward.team.net";
};

zone "18.172.in-addr.arpa" IN {
	tpye master;
	file "/etc/bind/zones/reverse.team.net";
};
done

cat << done > /etc/bind/zones/forward.ncaecybergames.org
$TTL	86400
@	IN	SOA	team$team.ncaecybergames.org root (
			      $serial		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			  86400 )	; Negative Cache TTL
;
@	IN	NS	$name
$name	IN	A	192.168.$team.12
ns1	IN	A	172.18.13.$team
www	IN	A	172.18.13.$team
files	IN	A	172.18.14.$team
shell	IN	A	172.18.14.$team
done

cat << done > /etc/bind/zones/reverse.ncaecybergames.org
$TTL	86400
@	IN	SOA	team$team.ncaecybergames.org. root.team$team.ncaecybergames.org. (
			      $serial		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			  86400 )	; Negative Cache TTL
;
@	IN	NS	$name
$team.13	IN	PTR	ns1.team$team.ncaecybergames.org
$team.13	IN	PTR	www.team$team.ncaecybergames.org
$team.14	IN	PTR	files.team$team.ncaecybergames.org
$team.14	IN	PTR	shell.team$team.ncaecybergames.org

done

cat << done > /etc/bind/zones/forward.team.net
$TTL	86400
@	IN	SOA	team$team.net root (
			      $serial		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			  86400 )	; Negative Cache TTL
;
@	IN	NS	$name
$name	IN	A	192.168.$team.12
ns1	IN	A	192.168.$team.12
www	IN	A	192.168.$team.5
db1	IN	A	192.168.$team.7
done

cat << done > /etc/bind/zones/reverse.team.net
$TTL	86400
@	IN	SOA	team$team.net root (
			      $serial		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			  86400 )	; Negative Cache TTL
;
@	IN	NS	$name
12	IN	PTR	ns1
7	IN	PTR	db1
5	IN	PTR	www
done