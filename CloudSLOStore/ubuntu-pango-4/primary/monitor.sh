#!/bin/sh

# disk io
id=$1
sec=1

# cpu usage (>100%)
top -b | awk 'BEGIN{print "usage"}/mongod/ {print $9};fflush(stdout)' > cpu.$id.txt &

# disk r, w, %
disk='sda4'
sudo iostat -x $disk $sec | awk 'BEGIN{print "rkB/s\twkB/s\tutil"}/sda4/{print $4"\t"$5"\t"$16; fflush(stdout)}' > disk.$id.txt &
sudo iostat -x $disk $sec | awk 'BEGIN{print "iowait\tidle"}/avg-cpu/{getline;print$4"\t"$6; fflush(stdout)}' > iowait.$id.txt &

# sudo kill -9 `pidof iostat` `pidof top`
