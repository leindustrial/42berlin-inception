#dockerfile for Nginx

FROM debian:bullseye

WORKDIR /nginx/

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y nginx openssl && \
    mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=DE/ST=BER/L=BERLIN/O=42/OU=student/CN=ole"

COPY conf/nginx.conf /etc/nginx/conf.d/server.conf

EXPOSE 443

WORKDIR /

CMD [ "nginx","-g","daemon off;" ]
