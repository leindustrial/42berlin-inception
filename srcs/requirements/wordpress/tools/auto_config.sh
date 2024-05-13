#!/bin/bash

cd /var/www/html

if [ ! -d "wp-admin" ]; then
	wp core download --allow-root
fi

while ! mysqladmin ping --host=$MYSQL_HOSTNAME --silent; do
	echo "Connecting to database"
	sleep 5
done

if [ ! -e "/var/www/html/wp-config.php" ]; then
	echo "Creating WP-config file"
	wp core download --path=/var/www/html --allow-root
	mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
	sed -i "s/password_here/$(cat $MYSQL_PASSWORD)/g" /var/www/html/wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" /var/www/html/wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" /var/www/html/wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/html/wp-config.php
	wp core install \
		--title=$WP_TITLE \
		--url=$DOMAIN_NAME \
		--admin_user=$WP_ADMIN \
		--admin_email=$WP_ADMIN_EMAIL \
		--admin_password=$(cat $WP_ADMIN_PASSWORD) \
		--allow-root
	wp user create $WP_USER $WP_USER_EMAIL \
		--user_pass=$(cat $WP_USER_PASSWORD) \
		--role=editor \
		--allow-root
else
	echo "WP-config file exists"
fi

if [ ! -d /run/php ]; then
	echo "creating /run/php"
	mkdir /run/php
fi

/usr/sbin/php-fpm7.4 -F