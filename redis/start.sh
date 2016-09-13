#!/bin/bash

set -e
exec 2>&1

configFile=/etc/redis/redis.conf
logpath=/var/log/redis
dbpath=/var/lib/redis

if [ $REDIS_PASSWORD ]; then
  echo "requirepass $REDIS_PASSWORD" >> $configFile
fi

chown -R redis $logpath
chown -R redis $dbpath

/sbin/setuser redis redis-server $configFile
