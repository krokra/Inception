# Utilise une image Debian Bookworm
FROM debian:bookworm-slim

# Installe les dépendances nécessaires
RUN apt update && apt install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-curl \
    php8.2-gd \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-soap \
    php8.2-xml \
    php8.2-xmlrpc \
    php8.2-zip \
    wget \
    unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Crée le dossier /var/www/html
RUN mkdir -p /var/www/html

# Télécharge et installe WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html

# Copie le fichier de configuration pour php-fpm
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Expose le port 9000 (port par défaut de php-fpm)
EXPOSE 9000

# Démarre php-fpm en mode "foreground"
CMD ["php-fpm8.2", "-F"]