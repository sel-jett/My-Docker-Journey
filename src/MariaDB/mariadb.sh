#!/bin/bash

set -e

echo "starting mariadb"

service mariadb start

echo "configurating mariadb"

mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS wordpress"
mariadb -uroot -e "CREATE USER IF NOT EXISTS salah@'%' IDENTIFIED BY '123456789'"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'salah'@'%'"
mariadb -uroot -e "FLUSH PRIVILEGES"

echo "done configurating mariadb"

service mariadb stop

exec mariadbd --bind-address=0.0.0.0