#!/bin/bash


echo "SerHack Script for setup fast and well the VPS for MAP."

echo Text the city near the VPS

read -r city

echo "The city is $city . Hostname will be MAP-$city-0"

hostname="MAP-$city-0"

echo Creating the Monero folder

cd /usr/bin || return

mkdir monero

cd monero || return

echo "Downloading Monero"

wget https://downloads.getmonero.org/linux64

echo "Unzipping monero"

tar -vxf ./linux64

echo "hostname : $hostname"

echo "$hostname" > /etc/hostname

echo "Welcome to $hostname part of the MAP (Monero Archival Project). Project coordinator : Isthumus Crypto. Infra Coordinator : SerHack. Any issues should be reported to the Project Coordinator" > /etc/motd

echo "Adding username MAP"

adduser map

echo "export PATH=$PATH:/usr/bin/monero" >> /home/map/.bashrc

echo "username MAP added"

echo "Config script ok"

