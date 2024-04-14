#!/bin/bash

# Move profile files so they don't get loaded
mv /etc/profyle.d /root; mv /etc/profyle /root

# Remove all common runcommand files in /home and /root
for f in ~/.profile ~/.bashrc ~/.bash_login; do 
        find /home /root -iwholename "$f" -delete 
done
