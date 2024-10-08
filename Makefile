WP_DATA = /home/data/wordpress
MDB_DATA = /home/data/mariadb
COMPOSE = docker-compose -f
COMPOSE_FILE = srcs/docker-compose.yml

all: build up


up:
	$(COMPOSE) $(COMPOSE_FILE) up -d

start:
	$(COMPOSE) $(COMPOSE_FILE) start

build:
	mkdir -p $(WP_DATA)
	mkdir -p $(MDB_DATA)
	$(COMPOSE) $(COMPOSE_FILE) build

down: stop
	$(COMPOSE) $(COMPOSE_FILE) down

stop:
	$(COMPOSE) $(COMPOSE_FILE) stop


clean:
	docker stop $$(docker ps -qa) || true
	docker rm $$(docker ps -qa) || true
	docker rmi -f $$(docker images -q) || true
	docker volume rm $$(docker volume ls -q) || true
	docker network rm $$(docker network ls -q) || true
	rm -rf $(WP_DATA) || true
	rm -rf $(MDB_DATA) || true

re: prune all

prune: clean
	docker system prune -a --volumes -f