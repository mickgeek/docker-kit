FROM php:7.2.0-fpm-stretch

ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_DEPS=" \
        # Postgres dependencies
        libpq-dev \
        # GD dependencies
        libpng-dev \
        zlib1g-dev \
        libfreetype6-dev \
        # Imagick dependencies
        libmagickwand-dev \
        # Memcached dependencies
        libmemcached-dev \
        # XSL dependencies
        libxslt-dev \
    "

# Install required libraries
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        ${BUILD_DEPS} \
        # MTA
        postfix \
        # Composer dependencies
        git \
    && rm -rf /var/lib/apt/lists/*

ARG ICU_URL=http://download.icu-project.org/files/icu4c/60.1/icu4c-60_1-src.tgz

# Install Intl library from the source code
RUN curl -SLo /tmp/icu.tgz ${ICU_URL} \
    && tar -xzf /tmp/icu.tgz -C /tmp \
    && cd /tmp/icu/source \
    && ./configure --prefix=/usr/local \
    && make \
    && make install \
    && rm -rf /tmp/icu*

ARG PECL_IMAGICK_VERSION=3.4.3
ARG PECL_APCU_VERSION=5.1.8
ARG PECL_MEMCACHED_VERSION=3.0.4

# https://github.com/docker-library/php/issues/455
ENV PHP_CPPFLAGS="${PHP_CPPFLAGS} -std=c++11"

# Install extensions
RUN docker-php-ext-configure intl \
        --with-icu-dir=/usr/local \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include \
        --with-jpeg-dir=/usr/lib \
        --with-png-dir=/usr/lib \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        intl \
        pdo_mysql \
        pdo_pgsql \
        gd \
        # Magento dependencies
        bcmath \
        soap \
        xsl \
        # Composer dependencies
        zip \
    && pecl install \
        imagick-${PECL_IMAGICK_VERSION} \
        apcu-${PECL_APCU_VERSION} \
        memcached-${PECL_MEMCACHED_VERSION} \
    && docker-php-ext-enable \
        mysqli \
        opcache \
        imagick \
        apcu \
        memcached \
    && rm -rf /tmp/pear/

# Cleanup build dependencies
RUN apt-get -y purge ${BUILD_DEPS}

COPY ./php.ini /usr/local/etc/php/
COPY ./opcache.ini /usr/local/etc/php/conf.d/
COPY ./www.conf /usr/local/etc/php-fpm.d/

ARG GITHUB_OAUTH_TOKEN
ARG COMPOSER_VERSION=1.5.2

# https://getcomposer.org/doc/03-cli.md#environment-variables
ENV COMPOSER_ALLOW_SUPERUSER=1

COPY ./composer-setup.sh /tmp/
RUN sh /tmp/composer-setup.sh && rm /tmp/composer-setup.sh

WORKDIR /srv/www

CMD service postfix start && php-fpm
