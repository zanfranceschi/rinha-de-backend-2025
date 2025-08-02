FROM redis:7.2-alpine
COPY ./redis.conf /usr/local/etc/redis/redis.conf
COPY ./init-redis.sh /init-redis.sh

RUN set -x \
  && chmod u+x /init-redis.sh

ENTRYPOINT ["/init-redis.sh"]