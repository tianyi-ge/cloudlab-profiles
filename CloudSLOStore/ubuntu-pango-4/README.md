# Usage of pango 4-replica

1. Copy the folders onto nodes

2. Run `./start.sh` on each mongodb server

3. Run `mongo` on majority and paste the first command in `mongo_config.js`
   ```js
   rs.initiate({
      _id: "rs0",
      members: [
         { _id: 1, host: "10.10.1.2:27017", priority: 10 },
         { _id: 2, host: "10.10.1.3:27017", priority: 0 },
         { _id: 3, host: "10.10.1.4:27017", priority: 0 },
         { _id: 4, host: "10.10.1.5:27017", priority: 0 },
      ],
       settings: {
         chainingAllowed : false
       }
   })
   ```
   
4. wait until it becomes primary

5. Back to client `~/mnt`, run `./run.sh <thread> <throu> <ops>` (e.g. ``./run.sh 60 10000 1000000``)

   1. It's majority by default
   2. It starts monitor on each mongodb server
   3. When it ends, all the db servers are closed; all the data are collected

1. Run `./main <thread> <throu> <ops>` on local machine to retrieve the data.