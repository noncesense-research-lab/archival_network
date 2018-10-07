#!/bin/sh
adduser map
usermod -aG sudo map
groupadd sshusers
adduser map sshusers