#!/bin/bash
set -e

# Wait for MariaDB to be ready
until mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1"; do
    echo "Waiting for MariaDB..."
    sleep 1
done

# Create database and user
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
    FLUSH PRIVILEGES;
EOSQL