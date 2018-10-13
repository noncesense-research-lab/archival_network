#!/bin/bash
echo -- MAP User Account: When prompted for UNIX Password, enter the private local password for map user. --
echo -- MAP User Account: When prompted for User Information, press ENTER for defaults. --
sudo adduser map
sudo usermod -aG sudo map
sudo groupadd sshusers
sudo adduser map sshusers
echo Complete: 8_map_user_account