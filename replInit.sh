#!/bin/bash

# exit early if this script has been run already
if [ -f /data/db/.initDone ]; then
  exit 0
fi

# set a default oplog size if not yet defined
availDiskSpace=$(df -k / | tail -1 | awk '{print $4}')
OPLOG_SIZE=$(($availDiskSpace*5/100))

echo "Creating replica set rs0 with oplog size ${OPLOG_SIZE}"

mongod --replSet rs0 --oplogSize ${MJSM_OPLOG_SIZE} --directoryperdb --storageEngine wiredTiger &

# wait for mongod to start
RET=1
printf "Waiting for mongod to start..."
while [[ RET -ne 0 ]]; do
  printf "."
  sleep 5
  mongostat -n 1 >/dev/null 2>&1
  RET=$?
done
printf "\n"

mongo admin --eval "rs.initiate()"
sleep 5
mongo admin --eval "rs.conf()"
sleep 5
mongo admin --eval "db.shutdownServer({force: 1});"

# make sure this script is only run once
touch /data/db/.initDone

echo "MONGO_OPLOG_URL=mongodb://<address>/local"
echo "Finished MongoDB setup."
