FROM composer/composer

COPY ./etc/php.ini /usr/local/etc/php/

# Set up the application directory.
VOLUME ["/data/app"]
WORKDIR /data/app
