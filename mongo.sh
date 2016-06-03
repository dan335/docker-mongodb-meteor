#!/bin/bash

./replInit.sh
cmd="mongod --directoryperdb --storageEngine wiredTiger"
exec $cmd
