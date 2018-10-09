#!/bin/bash
echo Enter the IP address of this MAP node:
read -r ip
echo Enter the domain name of this MAP node:
read -r domainname
# Note: $HOSTNAME is set by BASH
sudo echo "$ip $domainname $HOSTNAME" > /etc/hosts