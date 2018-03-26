#!/bin/bash

sleep 2
./replInit.sh
sleep 2
cmd="mongod --replSet rs0 --bind_ip_all --storageEngine wiredTiger"
exec $cmd
