FROM php:5.6

COPY ./etc/php.ini /usr/local/etc/php/

RUN apt-get update -y && \
    apt-get install -y \
    libmcrypt-dev \
    sqlite \
    libsqlite3-0 \
    libsqlite3-dev \
    openssl \
    libssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libbz2-dev \
    php-pear \
    curl \
    git \
    subversion \
    zlib1g-dev \
    libicu-dev \
    g++ \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install mysqli mbstring pdo_mysql pdo_sqlite mcrypt ftp gd intl bz2

# Install, Enable and Configure xdebug
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
RUN sed -i '1 a xdebug.var_display_max_depth=10' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.var_display_max_children=256' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i '1 a xdebug.var_display_max_data=1024' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install and Enable zip
RUN pecl install zip
Run docker-php-ext-enable zip

# Set up the application directory.
VOLUME ["/data/app"]
WORKDIR /data/app


# Set up the command arguments.
ENTRYPOINT ["php", "artisan"]
CMD ["--help"]

ENV APP_ENV docker
