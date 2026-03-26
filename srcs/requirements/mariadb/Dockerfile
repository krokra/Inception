# Utilise une image Debian stable
FROM debian:stable-slim

# Installe MariaDB
RUN apt update && apt install -y mariadb-server

# Vérifie si le groupe et l'utilisateur mysql existent déjà, sinon les crée
RUN if ! getent group mysql >/dev/null; then \
        groupadd -r mysql; \
    fi && \
    if ! id mysql >/dev/null 2>&1; then \
        useradd -r -g mysql mysql; \
    fi

# Crée le dossier pour les données MariaDB et définit les permissions
RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Crée le dossier pour les scripts d'initialisation
RUN mkdir -p /docker-entrypoint-initdb.d

# Copie le fichier de configuration my.cnf
COPY conf/my.cnf /etc/mysql/my.cnf

# Copie le script d'initialisation
COPY conf/init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Expose le port 3306
EXPOSE 3306

# Change l'utilisateur pour mysql avant de démarrer mysqld
USER mysql

# Démarre MariaDB
CMD ["mysqld"]