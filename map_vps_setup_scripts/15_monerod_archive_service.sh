#!/bin/bash
sudo cp ../map_vps_setup_files/monerod-archive.service /etc/systemd/system/monerod-archive.service
sudo systemctl daemon-reload
sudo systemctl enable monerod-archive
sudo systemctl start monerod-archive
sudo systemctl status monerod-archive
echo Complete: 15_monerod_archive_service