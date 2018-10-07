#!/bin/sh
sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow from any to any port 4422 proto tcp
sudo ufw allow from any to any port 18080 proto tcp
sudo ufw enable
sudo ufw logging on