#!/bin/sh
echo Enter the city this MAP node where is located:
read -r city
echo Enter the index of this MAP node in that city:
read -r cityindex
echo "MAP-$city-$cityindex" > /etc/hostname
sudo hostname -F /etc/hostname