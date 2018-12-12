FROM php:7.2.0-apache-stretch

RUN a2enmod rewrite

COPY ./vhosts/ /etc/apache2/sites-enabled/
