#!/bin/bash

sleep 2
./replInit.sh
sleep 2
cmd="mongod --replSet rs0 --directoryperdb false --storageEngine wiredTiger"
exec $cmd
