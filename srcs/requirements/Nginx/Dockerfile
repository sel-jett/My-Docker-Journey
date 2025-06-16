FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MA/ST=salah/L=Morocco/O=42/CN=sel-jett.42.fr"

COPY nginx.conf /etc/nginx/sites-enabled

EXPOSE 443

WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]
