# disk io
id=1
sec=1
pid=`pidof mongod`
pidstat -d $sec -p $pid > io.$id.txt &

# cpu
pidstat -u $sec -p $pid > cpu.$id.txt &

kill `pidof pidstat`

# disk storage
mongo ycsb --eval 'db.stats()' > storage.txt

# cpu wa + mongod
top -p `pidof mongod` -b | grep '%Cpu\|mongod' > wa_cpu.$id.txt &
grep '%Cpu' wa_cpu.$id.txt | awk '{ print $10 }' > wa.$id.txt
grep 'mongod' wa_cpu.$id.txt | awk '{ print $8 }' > cpu.$id.txt

# disk r, w, %
sudo iotop -b | grep mongod | awk '{ print $4,$6,$10 }'

# disk + network busy %
atop | grep 'DSK |\|NET | ens1f1' > dsk.$ip.txt # ens1f1 is interface name

