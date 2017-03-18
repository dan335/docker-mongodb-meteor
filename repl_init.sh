#!/bin/bash

# exit early if this script has been run already
if [ -f /data/db/.init_done ]; then
  exit 0
fi

echo "[x] Launching MongoDB for setup"

mongod --replSet rs0 &

echo "[x] Waiting for MongoDB to start"
while ! mongo --eval "db.version()" > /dev/null 2>&1; do sleep 0.1; done

echo "[x] Initializing replicaset"
mongo local --eval "rs.initiate()"
sleep 2
mongo local --eval "rs.conf()"
sleep 2
mongo admin --eval "db.shutdownServer({force: 1});"

echo "[x] Waiting for MongoDB to stop"
while mongo --eval "db.version()" > /dev/null 2>&1; do sleep 0.1; done
kill -2 %1

# make sure this script is only run once
touch /data/db/.init_done

echo "[x] Setup completed"
