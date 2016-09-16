FROM packageman/base:1.0.1

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV PHPIZE_DEPS autoconf file g++ gcc libc-dev make pkg-config re2c

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
		$PHPIZE_DEPS \
		ca-certificates \
		curl \
		libedit2 \
		libsqlite3-0 \
		libxml2 \
		xz-utils --no-install-recommends

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-maintainer-zts
ENV PHP_VERSION ${PHP_VERSION:-5.6.25}
ENV PHP_FILENAME php-$PHP_VERSION.tar.xz
ENV PHP_SOURCE /usr/src/php
ENV PHP_BUILD_DEPS libcurl4-openssl-dev libedit-dev libsqlite3-dev libssl-dev libxml2-dev libpng-dev libmcrypt-dev

RUN cd /usr/src \
 && curl -fSL "https://secure.php.net/get/${PHP_FILENAME}/from/this/mirror" -o php.tar.xz \
 && mkdir -p $PHP_SOURCE \
 && tar -Jxf /usr/src/php.tar.xz -C $PHP_SOURCE --strip-components=1

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        $PHP_BUILD_DEPS \
        $PHP_EXTRA_BUILD_DEPS --no-install-recommends \
 && cd $PHP_SOURCE \
 && ./configure \
        --with-config-file-path="$PHP_INI_DIR" \
        --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
        --disable-cgi \
        --enable-ftp \
        --enable-mbstring \
        --enable-mysqlnd \
        --enable-pcntl \
        --with-gd \
        --with-mcrypt \ 
        --with-curl \
        --with-libedit \
        --with-openssl \
        --with-zlib \
        $PHP_EXTRA_CONFIGURE_ARGS \
 && make -j"$(nproc)" \
 && make install \
 && make clean

COPY php_ext_install /usr/local/bin

ENV PHP_EXTENSION pthreads-2.0.10 redis-2.2.8 mongo-1.6.14
RUN php_ext_install $PHP_EXTENSION

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* $PHP_SOURCE
