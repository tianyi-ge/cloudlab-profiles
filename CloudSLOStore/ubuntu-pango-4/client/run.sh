url='mongodb://10.10.1.2:27017/ycsb?replicaSet=rs0&w=majority&journal=true'
thread=$1
throu=$2
req=$3

for id in 2 3 4 5
do
	ssh -p 22 10.10.1.$id "cd ~/mnt && ./monitor.sh `expr $id - 1`";
done

# mongo '10.10.1.2:27017' ycsb --eval 'db.usertable.remove({})';
# ycsb/bin/ycsb load mongodb -s -P ycsb/workloads/workloadg -threads $thread -target $throu;
echo "====="$thread" "$throu"====="
ycsb/bin/ycsb run mongodb -s -p mongodb.url=$url -p operationcount=$req -p recordcount=0 -P ycsb/workloads/workloadg -threads $thread -target $throu > $thread.$throu.$req.txt;

for id in 2 3 4 5
do
	ssh -p 22 10.10.1.$id "sudo kill -9 \`pidof iostat\` \`pidof top\`";
	ssh -p 22 10.10.1.$id "cd ~/mnt && ./clean.sh";
done

./collect.sh
