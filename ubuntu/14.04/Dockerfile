FROM phusion/baseimage:0.9.18

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_NUMERIC en_US.UTF-8
ENV LC_TIME en_US.UTF-8
ENV LC_COLLATE en_US.UTF-8
ENV LC_MONETARY en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8
ENV LC_PAPER en_US.UTF-8
ENV LC_NAME en_US.UTF-8
ENV LC_ADDRESS en_US.UTF-8
ENV LC_TELEPHONE en_US.UTF-8
ENV LC_MEASUREMENT en_US.UTF-8
ENV LC_IDENTIFICATION en_US.UTF-8

COPY conf/sources.list /etc/apt/sources.list
COPY bin/ /usr/local/bin/

RUN chmod +x /usr/local/bin/apt-install

RUN apt-install python-software-properties build-essential curl git
