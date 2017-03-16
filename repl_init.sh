#!/bin/bash

# exit early if this script has been run already
if [ -f /data/db/.init_done ]; then
  exit 0
fi

echo "--- Starting MongoDB setup. ---"

mongod --replSet rs0 &

# wait for mongod to start
while ! mongo --eval "db.version()" > /dev/null 2>&1; do sleep 0.1; done

mongo admin --eval "rs.initiate()"
sleep 5
mongo admin --eval "rs.conf()"
sleep 5
mongo admin --eval "db.shutdownServer({force: 1});"

# make sure this script is only run once
touch /data/db/.init_done
