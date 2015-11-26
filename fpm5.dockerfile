FROM php:5.6-fpm

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

RUN apt-get update -y && \
    apt-get install -y \
    libmcrypt-dev \
    sqlite \
    libsqlite3-0 \
    libsqlite3-dev \
    openssl \
    libssl-dev

RUN docker-php-ext-install mbstring pdo_mysql pdo_sqlite mcrypt ftp

COPY ./php.ini /usr/local/etc/php/
