#!/bin/bash
echo $(($(date +%s%N)/1000000)) $1 $2 $3 $4 >> /opt/monerodarchive/reorgnotify.log
exit 0