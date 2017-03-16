#!/bin/sh

# Initialize replicaSet
sh /root/repl_init.sh || exit $?

# Make sure that database is owned by user mongodb
[ "$(stat -c %U /data/db)" = mongodb ] || chown -R mongodb /data/db

exec su -s /bin/sh -c "exec mongod" mongodb
