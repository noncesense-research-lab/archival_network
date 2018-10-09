#!/bin/bash
sudo mkdir /home/map/.ssh
sudo chmod 700 /home/map/.ssh
sudo cp ../map_vps_setup_files/authorized_keys /home/map/.ssh/authorized_keys
sudo chmod 600 /home/map/.ssh/authorized_keys