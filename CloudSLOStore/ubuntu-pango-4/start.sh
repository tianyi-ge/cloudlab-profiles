#!/bin/sh

ssd=/dev/sda4
sudo mkfs.ext4 $ssd;
dir=/local/ssd
sudo mkdir -p $dir
sudo mount $ssd $dir
sudo chown -R tianyige $dir
echo $ssd' '$dir' ext4 defaults 0 0' | sudo tee -a /etc/fstab

wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org=4.4.0 mongodb-org-server=4.4.0 mongodb-org-shell=4.4.0 mongodb-org-mongos=4.4.0 mongodb-org-tools=4.4.0

xs $dir
m="mongod"
[ ! -d "db" ] && mkdir db
$m --dbpath db --port 27017 --logpath db.log --replSet rs0 --bind_ip localhost,$ip &

