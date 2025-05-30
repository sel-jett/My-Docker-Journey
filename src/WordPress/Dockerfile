FROM debian:bullseye

# Set environment variables with defaults
ENV WORDPRESS_DB_NAME=wordpress \
    WORDPRESS_DB_USER=wordpress_user \
    WORDPRESS_DB_PASSWORD=wordpress_password \
    WORDPRESS_DB_HOST=db \
    WORDPRESS_SITE_URL=localhost \
    WORDPRESS_SITE_TITLE="My WordPress Site" \
    WORDPRESS_ADMIN_USER=admin \
    WORDPRESS_ADMIN_PASSWORD=admin_password \
    WORDPRESS_ADMIN_EMAIL=admin@example.com

RUN apt-get update && apt-get install -y \
    php-fpm \
    curl \
    php-mysql \
    mariadb-client

COPY install-wordpress.sh /
RUN chmod +x /install-wordpress.sh

WORKDIR /

EXPOSE 9000

CMD ["./install-wordpress.sh"]
