#!/bin/sh

type=$1

ssh tianyige@hp034.utah.cloudlab.us 'cd ~/mnt && ./start.sh 1 $type &'
ssh tianyige@hp040.utah.cloudlab.us 'cd ~/mnt && ./start.sh 2 $type &'
ssh tianyige@hp020.utah.cloudlab.us 'cd ~/mnt && ./start.sh 3 $type &'
ssh tianyige@hp033.utah.cloudlab.us 'cd ~/mnt && ./start.sh 4 $type &'
