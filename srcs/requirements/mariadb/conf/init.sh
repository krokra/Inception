#!/bin/bash
set -e

# Lire les mots de passe depuis les fichiers secrets
if [ -f "$MYSQL_ROOT_PASSWORD_FILE" ]; then
    MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
    export MYSQL_ROOT_PASSWORD
else
    echo "ERROR: MYSQL_ROOT_PASSWORD_FILE not found or not set"
    exit 1
fi

if [ -f "$MYSQL_PASSWORD_FILE" ]; then
    MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
    export MYSQL_PASSWORD
else
    echo "ERROR: MYSQL_PASSWORD_FILE not found or not set"
    exit 1
fi

# Vérifier que les autres variables sont définies
if [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ]; then
    echo "ERROR: MYSQL_DATABASE or MYSQL_USER is not set"
    exit 1
fi

echo "Waiting for MariaDB to be ready..."

# Attendre que MariaDB soit prêt (en utilisant mysqladmin avec le mot de passe)
until mysqladmin ping -h localhost --silent -u root -p"${MYSQL_ROOT_PASSWORD}"; do
    echo "MariaDB not ready yet, waiting..."
    sleep 2
done

echo "MariaDB is ready! Creating database and user for WordPress..."

# Créer la base de données et l'utilisateur WordPress
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
  CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
  CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
  GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

echo "Database '${MYSQL_DATABASE}' and user '${MYSQL_USER}' created successfully!"