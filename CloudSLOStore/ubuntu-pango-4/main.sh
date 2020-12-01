#!/bin/sh
thread=$1
throu=$2
req=$3
group=$thread.$throu.$req

ssh tianyige@hp009.utah.cloudlab.us "~/mnt/run.sh $1 $2 $3";

[ ! -d $group ] && mkdir $group

rsync -ave ssh tianyige@hp009.utah.cloudlab.us:~/mnt/results/ $group/
rsync -ave ssh tianyige@hp009.utah.cloudlab.us:~/mnt/$group.txt $group/

