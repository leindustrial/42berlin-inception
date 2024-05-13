FROM debian:bullseye

WORKDIR /mariadb/

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y iputils-ping mariadb-server

COPY conf/my.cnf /etc/.

COPY tools/auto_config.sh /usr/local/bin/auto_config.sh

RUN chmod +x /usr/local/bin/auto_config.sh && \
    mkdir /run/mysqld && \
    chmod 777 /run/mysqld

EXPOSE 3306

WORKDIR /

ENTRYPOINT ["bash", "/usr/local/bin/auto_config.sh"]
