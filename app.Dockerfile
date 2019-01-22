FROM php:7.3.1-fpm

# RUN apt-get update && apt-get install -y libmcrypt-dev \
#     mysql-client libmagickwand-dev --no-install-recommends \
#     && pecl install imagick \
#     && docker-php-ext-enable imagick \
#     && docker-php-ext-install mcrypt pdo_mysql

RUN apt-get update && apt-get install -y mysql-client supervisor git nano \
    && docker-php-ext-install pdo_mysql && docker-php-ext-install mysqli

RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
&& curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
# Make sure we're installing what we think we're installing!
&& php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
&& rm -f /tmp/composer-setup.*

WORKDIR /var/www

RUN groupadd -r app &&\
    useradd -r -g app -d /home/app -s /sbin/nologin -c "Docker image user" app

COPY ./.env.example ./.env
COPY laravel-worker.conf /etc/supervisor/conf.d

RUN touch /var/run/supervisor.sock && chmod 777 /var/run/supervisor.sock \
    && service supervisor stop \
    && service supervisor start \
    && supervisorctl reread \
    && supervisorctl update \
    && supervisorctl start laravel-worker:* \
    && supervisorctl restart laravel-worker:*