#!/bin/bash

set -e

echo "starting mariadb"

service mariadb start

echo "configurating mariadb database : '$MARIADB_db'"

mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS \`$MARIADB_db\`"
mariadb -uroot -e "CREATE USER IF NOT EXISTS '$MARIADB_user'@'%' IDENTIFIED BY '$MARIADB_password'"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON \`$MARIADB_db\`.* TO '$MARIADB_user'@'%'"
mariadb -uroot -e "FLUSH PRIVILEGES"

echo "done configurating mariadb"

service mariadb stop

exec mariadbd --bind-address=0.0.0.0