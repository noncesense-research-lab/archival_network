#!/bin/bash
# app
sudo mkdir /usr/bin/monero
sudo chown map:map /usr/bin/monero
sudo chmod 755 /usr/bin/monero
# data
sudo mkdir /var/lib/monero
sudo chown map:map /var/lib/monero
sudo chmod 751 /var/lib/monero
# log
sudo mkdir /var/log/monero
sudo chown map:map /var/log/monero
sudo chmod 644 /var/log/monero
# archive data
sudo mkdir /opt/monerodarchive
sudo chown map:map /opt/monerodarchive
sudo chmod 666 /opt/monerodarchive