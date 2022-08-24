FROM php:apache-buster

COPY ./src/ /var/www/html

RUN apt-get update && apt-get install -y \
    unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY --from=composer:2.3 /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1

ENV COMPOSER_HOME /composer

ENV PATH $PATH:/composer/vendor/bin

RUN composer install

ENTRYPOINT [ "/var/www/html/entrypoint.sh" ]
