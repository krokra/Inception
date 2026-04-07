# Utilise une image Debian stable
FROM debian:stable-slim

# Installe MariaDB et mysql client (pour mysqladmin)
RUN apt update && apt install -y mariadb-server mariadb-client

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
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d
RUN chmod 755 /docker-entrypoint-initdb.d

# Copie le fichier de configuration my.cnf
COPY conf/my.cnf /etc/mysql/my.cnf

# Copie le script d'initialisation
COPY conf/init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Copie le script d'entrée
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Expose le port 3306
EXPOSE 3306

# Change l'utilisateur pour mysql
USER mysql

# Démarre avec le script d'entrée
ENTRYPOINT ["/docker-entrypoint.sh"]