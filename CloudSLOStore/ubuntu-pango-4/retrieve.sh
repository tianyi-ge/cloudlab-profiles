#!/bin/sh
thread=$1
throu=$2
req=$3
type=$4 # < mongod | mongod.ec >
group=$thread.$throu.$req.$type

# ssh tianyige@hp009.utah.cloudlab.us "cd ~/mnt && ./run.sh $1 $2 $3 $4";

[ ! -d $group ] && mkdir $group

rsync -ave ssh tianyige@hp009.utah.cloudlab.us:~/mnt/results/ $group/
rsync -ave ssh tianyige@hp009.utah.cloudlab.us:~/mnt/$group.txt $group/

