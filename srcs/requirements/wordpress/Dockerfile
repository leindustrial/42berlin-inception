FROM	debian:bullseye

WORKDIR /wordpress/

RUN		apt-get update -y && apt-get upgrade -y && \
		apt-get install -y \
		curl \
		iputils-ping \
		mariadb-client \
		php \
		php-fpm \
		php-mysql && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY	tools/auto_config.sh /usr/local/bin

RUN		chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

WORKDIR /

ENTRYPOINT [ "bash", "/usr/local/bin/auto_config.sh" ]