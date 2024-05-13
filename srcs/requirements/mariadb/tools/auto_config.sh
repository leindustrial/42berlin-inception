#!/bin/bash

echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '$(cat $MYSQL_PASSWORD)';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '$(cat $MYSQL_PASSWORD)';
ALTER USER 'root'@'%' IDENTIFIED BY '$(cat $MYSQL_ROOT_PASSWORD)';
FLUSH PRIVILEGES;" > /etc/mysql/init.sql

# Start the MariaDB server
exec mysqld_safe --bind_address=0.0.0.0
