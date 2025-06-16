all:
	mkdir -p /home/sel-jett/data/mariadb
	mkdir -p /home/sel-jett/data/wordpress
	sudo chmod 777 /home/sel-jett/data/wordpress
	sudo chmod 777 /home/sel-jett/data/mariadb
	cd srcs && sudo docker compose --env-file .env up --build

detached:
	cd /home/seljett/Documents/My-Docker-Journey/srcs && \
	sudo docker compose --env-file .env up  --build -d

down:
	cd /home/seljett/Documents/My-Docker-Journey/srcs && \
	docker compose down -v

stop:
	cd /home/seljett/Documents/My-Docker-Journey/srcs && \
	docker compose down;

remove:
	docker rm -f $(docker ps -aq)
	docker rmi -f $(docker images -aq)

remove-v:
	rm -rf /home/sel-jett/data/mariadb
	rm -rf /home/sel-jett/data/wordpress

clean:
	cd /home/seljett/Documents/My-Docker-Journey/srcs && \
	docker compose down;
