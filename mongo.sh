#!/bin/bash

./replInit.sh
cmd="mongod --replSet rs0 --directoryperdb --storageEngine wiredTiger"
exec $cmd
