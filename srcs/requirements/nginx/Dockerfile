FROM debian:stable-slim

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/psirault.key \
    -out /etc/nginx/ssl/psirault.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=psirault.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
