#!/bin/sh
echo Enter the IP address of this MAP node:
read -r ip
echo Enter the domain name of this MAP node:
read -r domainname
echo The hostname of this MAP node is:
hostname
echo Retype this hostname:
read -r hostname
sudo echo "$ip $domainname $hostname" > /etc/hosts