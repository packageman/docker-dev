FROM phusion/baseimage:0.9.18
# Base images: ubuntu 14.04
MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV HOME /root
ENV REFRESHED_AT 2016-07-15

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get update

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
