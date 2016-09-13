#!/bin/bash

set -e
exec 2>&1

configFile=/etc/redis/redis.conf

if [ $REDIS_PASSWORD ]; then
  echo "requirepass $REDIS_PASSWORD" >> $configFile
fi

/sbin/setuser redis redis-server $configFile