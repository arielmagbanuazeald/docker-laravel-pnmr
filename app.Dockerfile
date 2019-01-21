FROM php:7.3.1-fpm

# RUN apt-get update && apt-get install -y libmcrypt-dev \
#     mysql-client libmagickwand-dev --no-install-recommends \
#     && pecl install imagick \
#     && docker-php-ext-enable imagick \
#     && docker-php-ext-install mcrypt pdo_mysql

RUN apt-get update && apt-get install -y mysql-client \
    && docker-php-ext-install pdo_mysql && docker-php-ext-install mysqli

# RUN mkdir -p /var/www/public

# WORKDIR /var/www

# COPY ./hello.php ./public