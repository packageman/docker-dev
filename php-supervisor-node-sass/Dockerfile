FROM packageman/php:1.0.1

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y supervisor --no-install-recommends \
 && apt-add-repository -y ppa:brightbox/ruby-ng \
 && apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y ruby2.2 --no-install-recommends

RUN gem install sass

ENV NODE_VERSION   v0.12.2
ENV NODE_ROOT      ${HOME}/node-${NODE_VERSION}-linux-x64
ENV PATH           ${NODE_ROOT}/bin:${PATH}
ENV NODE_PATH      ${NODE_ROOT}/lib/node_modules

WORKDIR ${HOME}

RUN wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz -O /tmp/node.tar.gz \
 && tar xvf /tmp/node.tar.gz \
 && npm install -g grunt-cli

VOLUME /etc/supervisor/conf.d

RUN mkdir -p /etc/service/supervisor
ADD supervisor/start.sh /etc/service/supervisor/run
RUN chmod +x /etc/service/supervisor/run

WORKDIR /src

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
