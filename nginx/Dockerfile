FROM packageman/base:1.0.0

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        python-software-properties --no-install-recommends \
 && add-apt-repository ppa:nginx/stable \
 && apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        nginx --no-install-recommends

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /etc/service/nginx
ADD start.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

EXPOSE 80 443

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
