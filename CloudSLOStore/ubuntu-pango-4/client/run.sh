#!/bin/bash

thread=$1
throu=$2
req=$3
type=$4

# batchflag='-p mongo.batchsize=1000'

if [ -z "$4" ]; then
	url='mongodb://10.10.1.2:27017/ycsb?w=2&journal=true'
	rend=4
else
	url='mongodb://10.10.1.2:27017/ycsb?w=3&journal=true'
	rend=5
fi

for (( id=2; id<=$rend; id++ )); do
	ssh -p 22 10.10.1.$id "cd ~/mnt && ./monitor.sh `expr $id - 1`";
	echo `expr $id - 1`' is monitoring'
done

# mongo '10.10.1.2:27017' ycsb --eval 'db.usertable.remove({})';
# ycsb/bin/ycsb load mongodb -s -P ycsb/workloads/workloadg -threads $thread -target $throu;
echo "====="$thread" "$throu"====="
ycsb/bin/ycsb run mongodb -s -p mongodb.url=$url -p operationcount=$req \
	-p recordcount=0 $batchflag -P ycsb/workloads/workloadg \
	-threads $thread -target $throu \
	> $thread.$throu.$req.$type.txt;

for (( id=2; id<=$rend; id++ )); do
	ssh -p 22 10.10.1.$id "cd ~/mnt && mongo ycsb --eval 'db.stats()' > storage.`expr $id - 1`.txt";
	ssh -p 22 10.10.1.$id "sudo kill -9 \`pidof iostat\` \`pidof top\`";
	ssh -p 22 10.10.1.$id "cd ~/mnt && ./clean.sh";
	echo `expr $id - 1`' is killed'
done

./collect.sh
