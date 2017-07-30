See https://hub.docker.com/_/mongo/

https://hub.docker.com/r/dan335/mongodb-meteor/

This adds a replica set for Meteor.  Meteor > 1.4 required.

```
MONGO_URL=mongodb://<link>/<db>
mongodb://oplogger:oplogger@<link>/local?authSource=admin
```

There is no security.  Use Docker links instead.
