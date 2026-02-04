FROM debian:stable-slim

RUN apt update && apt install -y mariadb-server

RUN mkdir -p /docker-entrypoint-initdb.d

COPY conf/init.sh /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["mysqld"]
