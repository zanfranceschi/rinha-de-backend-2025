#!/bin/sh

mkdir -p /var/run/redis
chown redis:redis /var/run/redis

exec redis-server /usr/local/etc/redis/redis.conf
