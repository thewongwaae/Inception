SRC = ./srcs/docker-compose.yml
COMPOSE = docker-compose -f

# ----- build ----- #

up:
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress
	$(COMPOSE) $(SRC) build
	$(COMPOSE) $(SRC) up -d

down:
	$(COMPOSE) $(SRC) down

# ----- services ----- #

start:
	$(COMPOSE) $(SRC) start

ps:
	docker ps -a

mariadb:
	docker exec -it mariadb bash

nginx:
	docker exec -it nginx bash

wordpress:
	docker exec -it wordpress bash

stop:
	$(COMPOSE) $(SRC) stop

# ----- clean ----- #

clean:
	docker system prune -f

fclean:
	docker system prune --all -f

re: down fclean up