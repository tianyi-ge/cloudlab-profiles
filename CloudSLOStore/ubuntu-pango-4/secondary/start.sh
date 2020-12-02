#!/bin/sh

t=$2 # < None | ec >

[ ! -d "db" ] && mkdir db;
mongod$t --dbpath db --port 27017 --logpath db.log --replSet rs0 --bind_ip localhost,10.10.1.`expr $1 + 1` &
