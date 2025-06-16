#!/bin/bash

echo "Installing WordPress..."

set -e

sleep 10

if ! command -v wp &> /dev/null; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

    echo "Downloading WordPress..."

    chmod +x wp-cli.phar

    mv wp-cli.phar /usr/local/bin/wp

    echo "wp installed successfuly"
else
    echo "wp already installed"
fi

echo "Creating WordPress directory..."

mkdir -p /var/www/html

cd /var/www/html

if [ ! -f "wp-congfig-sample.php" ] && [ ! -f "wp-config.php" ]; then

    echo "Downloading WordPress core..."

    wp core download --allow-root

    echo "WordPress core downloaded succesfully"
else
    echo "WordPress core... already installed"
fi

if [ ! -f "wp-config.php" ]; then

    echo "Creating WordPress configuration..."

    wp config create --allow-root \
        --dbname=$MARIADB_db \
        --dbuser=$MARIADB_user \
        --dbpass=$MARIADB_password \
        --dbhost=$MARIADB_host

    echo "WordPress configuration installed successfuly"
else
    echo "WordPress configuration already installed"
fi


if ! wp core is-installed --allow-root 2>/dev/null; then

    echo "Installing WordPress..."

    wp core install --allow-root \
        --url=$url \
        --title=$title \
        --admin_user=$admin_user \
        --admin_password=$admin_password \
        --admin_email=$admin_email

    echo "WordPress installed successfully!"
else
    echo "WordPress already installed!"
fi

echo "Creating WordPress author..."

if wp user get "$author_user" --field=ID --allow-root > /dev/null 2>&1; then
    echo "User $author_user already exist"
else
    wp user create "$author_user" "$author_email" \
        --role=author \
        --user_pass="$author_password" \
        --allow-root
    echo "Author user created successfully!"
fi

sed -i -e 's|/run/php/php7.4-fpm.sock|0.0.0.0:9000|g' /etc/php/7.4/fpm/pool.d/www.conf


service php7.4-fpm start
service php7.4-fpm stop

php-fpm7.4 -F

#/etc/php/7.4/fpm/pool.d/www.conf