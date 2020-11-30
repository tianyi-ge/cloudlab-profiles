#!/bin/sh

# disk io
id=$1
sec=1
pid=`pidof mongod`

# cpu usage (>100%)
top -p `pidof mongod` -b | grep 'mongod' | awk '{ print $8 }' > cpu.$id.txt &

# disk r, w, %
disk='sda4'
sudo iotop -xm $disk $sec > stats.$id.txt &
