rs.initiate({
   _id: "rs0",
   members: [
      { _id: 0, host: "mongodb://192.168.6.0:27017", priority: 10 },
      { _id: 1, host: "mongodb://192.168.6.1:27017", priority: 0 },
      { _id: 2, host: "mongodb://192.168.6.2:27017", priority: 0 },
      { _id: 3, host: "mongodb://192.168.6.3:27017", priority: 0 }
   ],
    settings: {
      chainingAllowed : false
    }
})

conf = rs.conf()
conf.settings.numSourceSplits = 2
conf.settings.numTotalSplits = 4
rs.reconfig(conf)

