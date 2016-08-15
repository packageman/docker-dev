FROM packageman/base:1.0.0

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

# add-apt-repository is broken with non-UTF-8 locales,
# more details see https://github.com/oerdnj/deb.sury.org/issues/56
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        python-software-properties --no-install-recommends \
 && add-apt-repository -y ppa:ondrej/php5-5.6 \
 && apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        php5-cgi \
        php5-fpm \
        php5-xdebug \
        php5-curl \
        php5-mcrypt \
        php5-gd \
        php5-dev \
        php5-redis \
        php5-mongo --no-install-recommends

RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf \
 && sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini \
 && sed -i -e "s/error_log = \/var\/log\/php5-fpm.log/error_log = syslog/g" /etc/php5/fpm/php-fpm.conf \
 && sed -i -e "s/listen = \/var\/run\/php5-fpm.sock/listen = 9000/g" /etc/php5/fpm/pool.d/www.conf

RUN mkdir -p /etc/service/php-fpm
ADD start.sh /etc/service/php-fpm/run
RUN chmod +x /etc/service/php-fpm/run

EXPOSE 9000

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
