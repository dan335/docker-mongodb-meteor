#!/bin/bash

# exit early if this script has been run already
if [ -f /data/db/.initDone ]; then
  exit 0
fi

echo "--- Starting MongoDB setup. ---"

mongod --replSet rs0 --oplogSize 1073741824 --directoryperdb --storageEngine wiredTiger &

# wait for mongod to start
RET=1
printf "Waiting for mongod to start..."
while [[ RET -ne 0 ]]; do
  printf "."
  sleep 5
  mongostat -n 1 >/dev/null 2>&1
  RET=$?
done
echo " "

echo "--- Running rs.initiate() ---"
mongo admin --eval "rs.initiate()"
sleep 5
echo "--- Running rs.conf() ---"
mongo admin --eval "rs.conf()"
sleep 5
echo "--- Creating oplog user ---"
mongo admin --eval "db.createUser({ user:'oplogger', pwd:'oplogger', roles:[{rold:'read', db:'local'}] });"
sleep 5
echo "--- Running db.shutdownServer({force: 1}); ---"
mongo admin --eval "db.shutdownServer({force: 1});"

# make sure this script is only run once
touch /data/db/.initDone

echo "--- MONGO_OPLOG_URL=mongodb://oplogger:oplogger@<address>/local?authSource=admin"
echo "--- Finished MongoDB setup. ---"
