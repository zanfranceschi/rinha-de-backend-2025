#!/bin/sh
set -e

if [ -d /tmp/sockets ]; then
    chown redis:redis /tmp/sockets || true
    chmod 0777 /tmp/sockets
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"