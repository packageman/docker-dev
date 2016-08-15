FROM packageman/php:1.0.0

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        python-software-properties wget curl git supervisor --no-install-recommends \
 && apt-add-repository -y ppa:brightbox/ruby-ng \
 && apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y ruby2.2 --no-install-recommends 

RUN gem install sass

ENV NODE_VERSION   v0.12.2
ENV NODE_ROOT      ${HOME}/node-${NODE_VERSION}-linux-x64
ENV PATH           ${NODE_ROOT}/bin:${PATH}
ENV NODE_PATH      ${NODE_ROOT}/lib/node_modules

WORKDIR ${HOME}

RUN wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz \
 && tar xvf node-${NODE_VERSION}-linux-x64.tar.gz \
 && npm install -g grunt-cli

RUN mkdir -p /etc/service/supervisor
ADD start.sh /etc/service/supervisor/run
RUN chmod +x /etc/service/supervisor/run

VOLUME /etc/supervisor/conf.d

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/node-v0.12.2-linux-x64.tar.gz
