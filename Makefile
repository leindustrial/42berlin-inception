# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ole <ole@student.42berlin.de>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/29 12:51:23 by ole               #+#    #+#              #
#    Updated: 2024/01/29 12:51:30 by ole              ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#Makefile

NAME	=	inception

#COLORS
COLOR	=	\033[0;38;5;11m
RESET	=	\033[00m

.PHONY: all up start stop down ps images network volume logs clean fclean re

all:	up

up:
	if [ ! -d /home/ole/data/mariadb ]; \
		then sudo mkdir -p /home/ole/data/mariadb; \
	fi
	if [ ! -d /home/ole/data/wordpress ]; \
		then sudo mkdir -p /home/ole/data/wordpress; \
	fi
	sudo docker-compose -f ./srcs/docker-compose.yml up -d

down :
	sudo docker-compose -f ./srcs/docker-compose.yml down -v

stop :
	sudo docker-compose -f ./srcs/docker-compose.yml stop

clean: down
	sudo docker system prune -af

fclean: clean
	sudo docker network prune --force 
	sudo docker volume prune --force
	sudo docker system prune --all --force --volumes
	
re: clean up


.PHONY: all up down stop clean fclean re

