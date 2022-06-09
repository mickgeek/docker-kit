FROM php:7.4-fpm

ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_DEPS=" \
        # Postgres dependencies
        libpq-dev \
        # GD dependencies
        libpng-dev \
        libjpeg-dev \
        libfreetype-dev \
        # Imagick dependencies
        libmagickwand-dev \
        # Memcached dependencies
        libmemcached-dev \
        # ICU dependencies
        libicu-dev \
        # Composer dependencies
        libzip-dev \
    "

# Install required libraries
RUN apt-get update \
    &&  apt-get -y --no-install-recommends install \
        ${BUILD_DEPS} \
        git \
    && rm -rf /var/lib/apt/lists/*

ARG PECL_IMAGICK_VERSION=3.7.0
ARG PECL_APCU_VERSION=5.1.21
ARG PECL_MEMCACHED_VERSION=3.1.5
ARG PECL_XDEBUG_VERSION=3.1.3

RUN docker-php-ext-configure gd \
        --with-freetype \
    && docker-php-ext-install -j$(nproc) \
        gd \
        intl \
        pdo_pgsql \
        opcache \
        zip \
    && pecl install \
        imagick-${PECL_IMAGICK_VERSION} \
        apcu-${PECL_APCU_VERSION} \
        memcached-${PECL_MEMCACHED_VERSION} \
        xdebug-${PECL_XDEBUG_VERSION} \
    && docker-php-ext-enable \
        imagick \
        apcu \
        memcached \
        xdebug \
    && rm -rf /tmp/pear/

# Cleanup build dependencies
RUN apt-get -y purge ${BUILD_DEPS}

COPY ./php.ini /usr/local/etc/php/
COPY ./ext-opcache.ini /usr/local/etc/php/conf.d/
COPY ./ext-xdebug.ini /usr/local/etc/php/conf.d/
COPY ./www.conf /usr/local/etc/php-fpm.d/

# https://getcomposer.org/doc/03-cli.md#environment-variables
ENV COMPOSER_ALLOW_SUPERUSER=1

ARG GITHUB_OAUTH_TOKEN
ARG COMPOSER_VERSION=2.2.9

COPY ./composer-setup.sh /tmp/
RUN sh /tmp/composer-setup.sh && rm /tmp/composer-setup.sh

EXPOSE 9000

WORKDIR /home/apps
CMD ["php-fpm"]
