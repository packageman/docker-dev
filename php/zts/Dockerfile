FROM packageman/base:1.0.1

MAINTAINER Byron Zhang <xiaoqi_2591@outlook.com>

ENV PHPIZE_DEPS autoconf file g++ gcc libc-dev make pkg-config re2c
ENV PHP_BUILD_DEPS ${PHP_EXTRA_BUILD_DEPS libcurl4-openssl-dev libedit-dev libsqlite3-dev libssl-dev libxml2-dev ibpng-dev libmcrypt-dev}

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

RUN cd /usr/src \
 && curl -fSL "https://secure.php.net/get/${PHP_VERSION}.tar.xz/from/this/mirror" -o php.tar.xz \
 && mkdir -p /usr/src/php \
 && tar -Jxf /usr/src/php.tar.xz -C /usr/src/php --strip-components=1

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y $PHP_BUILD_DEPS \
 && cd /usr/src/php \
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

CMD ["/sbin/my_init", "--", "php", "-a"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*