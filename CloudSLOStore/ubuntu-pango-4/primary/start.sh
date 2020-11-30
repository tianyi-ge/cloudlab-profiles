#!/bin/sh

[ ! -d "db" ] && mkdir db;
mongod --dbpath db --port 27017 --logpath db.log --replSet rs0 --bind_ip localhost,10.10.1.2 &
