FROM redis:4.0.6

ARG REDIS_PASSWORD

RUN mkdir /usr/local/etc/redis \
    && { \
        echo "bind 0.0.0.0"; \
        echo "requirepass ${REDIS_PASSWORD}"; \
    } | tee /usr/local/etc/redis/redis.conf

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
