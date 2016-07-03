#!/bin/bash

if [ $PASS ]; then
	echo "requirepass $PASS" >> /etc/redis/redis.conf
fi

service redis-server start