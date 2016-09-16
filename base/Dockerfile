FROM phusion/baseimage:0.9.18
# Base images: ubuntu 14.04
MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV HOME /root

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        python-software-properties \
        build-essential \
        curl \
        git --no-install-recommends

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
