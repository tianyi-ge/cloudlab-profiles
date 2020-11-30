url='mongodb://10.10.1.2:27017/ycsb?replicaSet=rs0&w=majority&journal=true'
thread=$1
throu=$2
req=$3

# mongo '10.10.1.2:27017' ycsb --eval 'db.usertable.remove({})';
# ycsb/bin/ycsb load mongodb -s -P ycsb/workloads/workloadg -threads $thread -target $throu;
echo "====="$thread" "$throu"====="
ycsb/bin/ycsb run mongodb -s -p mongodb.url=$url -p operationcount=$req -P ycsb/workloads/workloadg -threads $thread -target $throu > $thread.$throu.$req.txt;

