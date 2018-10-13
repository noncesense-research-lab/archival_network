#!/bin/bash
# Set scripts as executable
sudo chmod +x ./1_software_update.sh
sudo chmod +x ./2_unattended_upgrades.sh
sudo chmod +x ./3_ufw_firewall.sh
sudo chmod +x ./4_utc_time_zone.sh
sudo chmod +x ./5_hostname.sh
sudo chmod +x ./6_hosts_file_self_entry.sh
sudo chmod +x ./7_motd.sh
sudo chmod +x ./8_map_user_account.sh
sudo chmod +x ./9_sshd_config.sh
sudo chmod +x ./10_sshd_authorized_keys.sh
sudo chmod +x ./11_sshd_restart.sh
sudo chmod +x ./12_monerod_archive_directories.sh
sudo chmod +x ./13_monerod_archive_download.sh
sudo chmod +x ./14_monerod_archive_conf.sh
sudo chmod +x ./15_monerod_archive_service.sh
sudo chmod +x ./16_logrotate_setup.sh
sudo chmod +x ./17_collectd_setup.sh
echo Complete: 0_map_vps_setup

# Run scripts
echo -- 1_software_update
sudo bash ./1_software_update.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 2_unattended_upgrades
sudo bash ./2_unattended_upgrades.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 3_ufw_firewall
sudo bash ./3_ufw_firewall.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 4_utc_time_zone
sudo bash ./4_utc_time_zone.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 5_hostname
sudo bash ./5_hostname.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 6_hosts_file_self_entry
sudo bash ./6_hosts_file_self_entry.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 7_motd
sudo bash ./7_motd.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 8_map_user_account
sudo bash ./8_map_user_account.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 9_sshd_config
sudo bash ./9_sshd_config.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 10_sshd_authorized_keys
sudo bash ./10_sshd_authorized_keys.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 11_sshd_restart
sudo bash ./11_sshd_restart.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 12_monerod_archive_directories
sudo bash ./12_monerod_archive_directories.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 13_monerod_archive_download
sudo bash ./13_monerod_archive_download.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 14_monerod_archive_conf.sh
sudo bash ./14_monerod_archive_conf.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 15_monerod_archive_service.sh
sudo bash ./15_monerod_archive_service.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 16_logrotate_setup.sh
sudo bash ./16_logrotate_setup.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key

echo -- 17_collectd_setup.sh
sudo bash ./17_collectd_setup.sh
read -rsp $'-- Press any key to continue --\n' -n 1 key