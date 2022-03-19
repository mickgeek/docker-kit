#!/bin/sh

EXPECTED_SIGNATURE=$(curl https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', '/tmp/composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm /tmp/composer-setup.php
    exit 1
fi

php /tmp/composer-setup.php --quiet --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}
rm /tmp/composer-setup.php
composer config -g github-oauth.github.com ${GITHUB_OAUTH_TOKEN}
exit $?
