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
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST"

echo "Installing WordPress..."

wp core install --allow-root \
    --url="$WORDPRESS_SITE_URL" \
    --title="$WORDPRESS_SITE_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL"

echo "WordPress installed successfully!"

# Start PHP-FPM
php-fpm7.4 -F
