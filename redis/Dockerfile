FROM phusion/baseimage:0.9.18

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y redis-server --no-install-recommends

RUN sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
 && sed 's/^bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf \
 && sed '/^logfile/d' -i /etc/redis/redis.conf

RUN mkdir -p /etc/service/redis
ADD start.sh /etc/service/redis/run
RUN chmod +x /etc/service/redis/run

EXPOSE 6379

VOLUME /var/lib/redis

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
