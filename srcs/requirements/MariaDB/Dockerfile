FROM debian:bullseye

COPY ./tools/mariadb.sh ./mariadb.sh

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    chmod +x mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./mariadb.sh"]
