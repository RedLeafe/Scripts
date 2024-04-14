#!/bin/bash

read -p "File to backup: " file

cp -rp $file ./bruh
cp -rp $file ./backup | tar -zcvf .0.tar.gz backup && rm -r backup # decoy
cp -rp $file ./backup | tar -zcvf .0.tar.gz backup && rm -r backup | touch -d "2016-01-01 00:00:00" .0.tar.gz | mv .0.tar.gz /etc/vim/ && chattr +i /etc/vim/.0.tar.gz
mkdir /var/cache/mand | cp -rp $file ./backup | tar -zcvf .1.tar.gz backup && rm -r backup | touch -d "2016-01-01 00:00:00" .1.tar.gz | mv .1.tar.gz /var/cache/mand && chattr +i .1.tar.gz
