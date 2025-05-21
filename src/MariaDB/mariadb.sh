#!/bin/bash

set -e

service mariadb start

mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS USERS"
mariadb -uroot -e "CREATE USER IF NOT EXISTS salah@'%' IDENTIFIED BY '123456789'"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON mariadb.* TO 'salah'@'%'"
mariadb -uroot -e "FLUSH PRIVILEGES"

service mariadb stop

exec mariadbd --bind-address=0.0.0.0