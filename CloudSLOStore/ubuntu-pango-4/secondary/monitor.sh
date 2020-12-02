#!/bin/sh

# disk io
id=$1
sec=1

# cpu usage (>100%)
top -b | awk 'BEGIN{print "usage"}/mongod/ {print $9};fflush(stdout)' > cpu.$id.txt &

# disk r, w, %
disk='sda4'
sudo iostat -x $disk $sec | awk 'BEGIN{print "w/s\twkB/s\tutil"}/sda4/{print $3"\t"$5"\t"$16; fflush(stdout)}' > disk.$id.txt &
sudo iostat -x $disk $sec | awk 'BEGIN{print "iowait\tidle"}/avg-cpu/{getline;print$4"\t"$6; fflush(stdout)}' > iowait.$id.txt &

# finish as top finish
echo 1min > uptime.$id.txt; while [ ! -z `pidof top` ]; do uptime | awk '{print$10}'; sleep 3; done >> uptime.$id.txt &

# sudo kill -9 `pidof iostat` `pidof top`
