#!/bin/bash
echo $(($(date +%s%N)/1000000)) $1 >> /opt/monerodarchive/blocknotify.log
exit 0