FROM php:8.1.4-apache

COPY ./src/ /var/www/html

RUN apt-get update && apt-get install -y \
    git

WORKDIR /var/www/html

COPY --from=composer:2.3 /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1

ENV COMPOSER_HOME /composer

ENV PATH $PATH:/composer/vendor/bin

RUN composer install

RUN ./colorcode.sh