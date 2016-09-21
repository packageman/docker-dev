FROM packageman/ubuntu:14.04

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV MONGO_VERSION ${MONGO_VERSION:-3.2.7}

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
 && echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org.list\
 && apt-install mongodb-org=${MONGO_VERSION} \
        mongodb-org-server=${MONGO_VERSION} \
        mongodb-org-shell=${MONGO_VERSION} \
        mongodb-org-mongos=${MONGO_VERSION} \
        mongodb-org-tools=${MONGO_VERSION}

ADD mongod.conf /etc/mongod.conf

RUN mkdir -p /etc/service/mongodb
ADD start.sh /etc/service/mongodb/run
RUN chmod +x /etc/service/mongodb/run

EXPOSE 27017

VOLUME ["/var/log/mongodb", "/var/lib/mongodb"]
