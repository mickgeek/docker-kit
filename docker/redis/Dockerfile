FROM redis:6.2.6-alpine

ARG REDIS_PASSWORD

RUN mkdir /usr/local/redis \
    && { \
        echo "bind 0.0.0.0"; \
        echo "requirepass ${REDIS_PASSWORD}"; \
    } | tee /usr/local/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/usr/local/redis/redis.conf"]
