FROM php

# Packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libbz2-dev \
    php-pear \
    curl \
    git \
    subversion \
  && rm -r /var/lib/apt/lists/*

# PHP Extensions
RUN docker-php-ext-install mcrypt zip bz2 mbstring pdo_mysql\
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd

# Memory Limit
RUN echo "memory_limit=2048M" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

# Set up the application directory.
VOLUME ["/data/app"]
WORKDIR /data/app

ENV LARAVEL_ENV docker

# Set up the command arguments.
ENTRYPOINT ["php", "artisan"]
CMD ["--help"]
