rs.initiate({
   _id: "rs0",
   members: [
      { _id: 1, host: "10.10.1.2:27017", priority: 10 },
      { _id: 2, host: "10.10.1.3:27017", priority: 0 },
      { _id: 3, host: "10.10.1.4:27017", priority: 0 },
   ],
   settings: {
      chainingAllowed: false
   }
})
