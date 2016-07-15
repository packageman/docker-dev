FROM packageman/base:1.0.0

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
 && echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org.list\
 && apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        mongodb-org=3.2.7 \
        mongodb-org-server=3.2.7 \
        mongodb-org-shell=3.2.7 \
        mongodb-org-mongos=3.2.7 \
        mongodb-org-tools=3.2.7 --no-install-recommends

RUN mkdir -p /etc/service/mongodb
ADD start.sh /etc/service/mongodb/run
RUN chmod +x /etc/service/mongodb/run

EXPOSE 27017

VOLUME /var/lib/mongodb

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
