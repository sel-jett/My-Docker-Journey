all:
	cd srcs; \
	docker compose up --env-file ./env --build;

detached:
	cd srcs; \
	docker compose up --env-file ./env --build -d;

stop:
	cd srcs; \
	docker compose down;

remove:
	cd srcs; \
	docker compose rm -f $(docker ps -aq);

clean:
	cd srcs; \
	docker compose down;