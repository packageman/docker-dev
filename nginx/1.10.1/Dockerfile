FROM packageman/ubuntu:14.04

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV NGINX_VERSION ${NGINX_VERSION:-1.10.1-0+trusty0}

RUN add-apt-repository -y ppa:nginx/stable \
 && apt-install nginx=${NGINX_VERSION}

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /etc/service/nginx
ADD start.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

EXPOSE 80 443

VOLUME /var/log/nginx
