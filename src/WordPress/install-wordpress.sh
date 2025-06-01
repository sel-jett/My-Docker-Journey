#!/bin/bash

echo "Installing WordPress..."

set -e

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

echo "Downloading WordPress..."

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

echo "Creating WordPress directory..."

mkdir -p /var/www/html

cd /var/www/html

echo "Downloading WordPress core..."

wp core download --allow-root

echo "Creating WordPress configuration..."

wp config create --allow-root \
    --dbname="wordpress" \
    --dbuser="salah" \
    --dbpass="123456789" \
    --dbhost="mariadb"

echo "Installing WordPress..."

wp core install --allow-root \
    --url="https://localhost:4443" \
    --title="obama" \
    --admin_user="admin" \
    --admin_password="admin" \
    --admin_email="admin@gmail.com"

echo "WordPress installed successfully!"



sed -i -e 's|/run/php/php7.4-fpm.sock|0.0.0.0:9000|g' /etc/php/7.4/fpm/pool.d/www.conf


service php7.4-fpm start
service php7.4-fpm stop

php-fpm7.4 -F

#/etc/php/7.4/fpm/pool.d/www.conf