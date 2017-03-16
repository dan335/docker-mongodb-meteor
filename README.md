Using https://github.com/mvertes/docker-alpine-mongo for a tiny mongo image.

This adds a replica set `rs0`.

```
MONGO_URL=mongodb://<link>/my_database?replicaSet=rs0
MONGO_URL_OPLOG=mongodb://<link>/local?replicaSet=rs0
```

There is no security.  Use Docker links instead.
