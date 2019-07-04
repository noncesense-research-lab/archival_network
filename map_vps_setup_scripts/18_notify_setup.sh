#!/bin/bash
sudo cp ../map_vps_setup_files/blocknotify.sh /opt/monerodarchive/blocknotify.sh
sudo cp ../map_vps_setup_files/reorgnotify.sh /opt/monerodarchive/reorgnotify.sh
chmod u+x /opt/monerodarchive/blocknotify.sh
chmod u+x /opt/monerodarchive/reorgnotify.sh
echo Complete: 18_notify_setup