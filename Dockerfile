FROM php:7.3.5-apache

RUN mkdir /srv/app
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf
COPY ./crt /etc/apache2/crt

RUN chown -R www-data:www-data /srv/app \
    && a2enmod rewrite \
    && a2enmod ssl

COPY ./src/composer.phar /bin/composer.phar

RUN chmod a+x /bin/composer.phar && apt-get update -y && apt-get install git unzip -y
CMD ["/bin/sh", "-c", "cd /srv/app && php /bin/composer.phar install && php /bin/composer.phar update && apache2-foreground"]
