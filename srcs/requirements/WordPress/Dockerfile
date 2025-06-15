FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    curl \
    php-mysql \
    mariadb-client

COPY ./tools/install-wordpress.sh /

RUN chmod +x /install-wordpress.sh

EXPOSE 9000

WORKDIR /var/www/html

CMD ["bash", "/install-wordpress.sh"]
