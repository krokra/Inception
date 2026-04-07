#!/bin/bash
set -e

# Démarrer MariaDB en arrière-plan
mysqld --user=mysql &
MYSQLD_PID=$!

# Attendre que MariaDB soit prêt
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h localhost --silent; do
    echo "MariaDB not ready yet, waiting..."
    sleep 2
done

echo "MariaDB is ready! Running initialization script..."

# Exécuter le script d'initialisation
if [ -f /docker-entrypoint-initdb.d/init.sh ]; then
    bash /docker-entrypoint-initdb.d/init.sh
fi

# Attendre que MariaDB se termine
wait $MYSQLD_PID