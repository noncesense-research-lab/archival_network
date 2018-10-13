#!/bin/bash
cd /usr/bin/monero
wget https://github.com/neptuneresearch/monerod-archive/releases/download/0.08/monerod-archive-v8-linux-amd64.tar.gz
tar -vxf ./monerod-archive-v8-linux-amd64.tar.gz
echo Complete: 13_monerod_archive_download