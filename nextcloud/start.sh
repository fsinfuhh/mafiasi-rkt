#!/bin/sh
export USER=www-data HOME=/home/www-data
# TODO: this is ugly
cp -r /var/www/nextcloud /opt/static
mkdir /run/php
chown www-data /opt/config/
chown www-data /opt/log
exec /usr/sbin/php-fpm7.3 --nodaemonize --fpm-config /etc/php/7.3/fpm/php-fpm.conf
