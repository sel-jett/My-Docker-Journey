FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

COPY ./mariadb.sh ./mariadb.sh

RUN chmod +x mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./mariadb.sh"]
