FROM packageman/ubuntu:14.04

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV REDIS_VERSION ${REDIS_VERSION:-3:3.0.7-1chl1~trusty1}

RUN add-apt-repository ppa:chris-lea/redis-server \
 && apt-install redis-server=${REDIS_VERSION}

ADD redis.conf /etc/redis/redis.conf

RUN mkdir -p /etc/service/redis
ADD start.sh /etc/service/redis/run
RUN chmod +x /etc/service/redis/run

EXPOSE 6379

VOLUME ["/var/lib/redis", "/var/log/redis"]
