#!/bin/bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo cp ../map_vps_setup_files/sshd_config /etc/ssh/sshd_config
echo Complete: 9_sshd_config