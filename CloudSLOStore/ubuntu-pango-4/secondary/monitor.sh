#!/bin/sh

# disk io
id=$1
sec=1
pid=`pidof mongod`
pidstat -d $sec -p $pid > io.$id.txt &

# cpu
pidstat -u $sec -p $pid > cpu.$id.txt &
