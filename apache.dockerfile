FROM php:apache

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

COPY etc/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY etc/apache/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN a2ensite 000-default
RUN a2ensite default-ssl
RUN a2enmod rewrite
RUN a2enmod ssl

RUN apt-get update -y && \
    apt-get install -y \
    libmcrypt-dev \
    sqlite \
    libsqlite3-0 \
    libsqlite3-dev \
    openssl \
    libssl-dev

RUN docker-php-ext-install mbstring pdo_mysql pdo_sqlite mcrypt ftp

COPY ./etc/php.ini /usr/local/etc/php/
COPY ./etc/certs/* /etc/ssl/certs/

# Enable and configure xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.remote_connect_back=1 ' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.remote_host=127.0.0.1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.overload_var_dump=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

ENV LARAVEL_ENV docker

EXPOSE 443
