FROM ubuntu
# следующие аргументы приходят из docker-compose. они переопределяют локальные
ARG CSP_DISTR
ARG CADES_DISTR
ARG PHP_URL
ARG URL_ROOT_TEST_CA
# локальные аргументы
ARG TZ=Europe/Moscow
ARG	CSP_DIR_TMP=/tmp/csp
ARG	CADES_DIR_TMP=/tmp/cades
ARG	PHP_DIR=/opt/php
ARG	PHP_SRC=/tmp/php
ARG CSP_INCLUDE=/opt/cprocsp/include
ENV PATH="/opt/cprocsp/bin/amd64:/opt/cprocsp/sbin/amd64:${PATH}"

# установка пакетов
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y \
		lsb-base \
		wget \
		ca-certificates \
		unzip \
		libxml2-dev \
		libboost-dev \
		php-dev \
		pkg-config \
		libsqlite3-dev \
		build-essential \
		gcc \
		g++

# установка csp
RUN mkdir -p $CSP_DIR_TMP && cd $CSP_DIR_TMP && \
	wget --quiet $CSP_DISTR && tar zxvf `ls -1` --strip-components=1 && \
	./install.sh && \
	dpkg -i `ls -1 | grep lsb- | grep devel` && \	
	cd && rm -rf $CSP_DIR_TMP

# установка кадеса
RUN	mkdir -p $CADES_DIR_TMP && cd $CADES_DIR_TMP && \
	wget --quiet $CADES_DISTR && tar zxvf `ls -1` --strip-components=1 && \
	dpkg -i `ls -1 |grep cades |grep .deb` && \
	dpkg -i `ls -1 |grep phpcades |grep .deb` && \
	cd && rm -rf $CADES_DIR_TMP

# установка php
RUN mkdir -p $PHP_SRC && cd $PHP_SRC && \
	wget --quiet $PHP_URL && tar zxvf `ls -1` --strip-components=1 && \
	./configure --prefix $PHP_DIR --enable-fpm && make && make install && \
	update-alternatives --install /usr/local/bin/php php $PHP_DIR/bin/php 100 && \
	wget https://www.cryptopro.ru/sites/default/files/products/cades/php7_support.patch.zip && \
	unzip php7_support.patch.zip && \
	cp php7_support.patch /opt/cprocsp/src/phpcades/ && \
	cd /opt/cprocsp/src/phpcades/ && \
	patch -p0 < ./php7_support.patch && \
	sed -i 's!PHPDIR=/php!PHPDIR=${PHP_SRC}!1' Makefile.unix && \
	sed -i 's!-fPIC -DPIC!-fPIC -DPIC -fpermissive!1' Makefile.unix && \
	eval `/opt/cprocsp/src/doxygen/CSP/../setenv.sh --64`; make -f Makefile.unix && \
	cp $PHP_SRC/php.ini-production $PHP_DIR/lib/php.ini && \
	sed -i '/; Dynamic Extensions ;/a extension=libphpcades.so'  $PHP_DIR/lib/php.ini && \
	EXT_DIR=`php -ini |grep extension_dir | grep -v sqlite | awk '{print $3}'` && \
	mv $PHP_DIR/etc/php-fpm.conf.default $PHP_DIR/etc/php-fpm.conf && \
	mv $PHP_DIR/etc/php-fpm.d/www.conf.default $PHP_DIR/etc/php-fpm.d/www.conf && \	
	sed -i 's!listen\s*=.*!listen = 9000!1' $PHP_DIR/etc/php-fpm.d/www.conf && \
	sed -i 's!nobody!www-data!g' $PHP_DIR/etc/php-fpm.d/www.conf && \
	ln -s /opt/cprocsp/src/phpcades/libphpcades.so $EXT_DIR/ && \
	chown -R www-data:www-data $PHP_DIR/var/log && \
	ln -s $PHP_DIR/sbin/php-fpm /usr/sbin/php-fpm && \	
	rm -rf /tmp/php

COPY cont /var/opt/cprocsp/keys/www-data/
RUN chown -R www-data:www-data /var/opt/cprocsp/keys/www-data/
USER www-data
RUN csptestf -absorb -certs

USER root
ADD $URL_ROOT_TEST_CA /root/test-ca-root.crt
RUN certmgr -inst -store mroot -file /root/test-ca-root.crt

#USER www-data
#RUN apt-get install -y php-fpm 																	&& \
#	sed -i 's!www-data!root!g' `find /etc/ -name www.conf`										&& \
#	sed -i 's!listen\s*=.*!listen = 9000!1' `find /etc/ -name www.conf`							&& \
#	mkdir -p /run/php
#sed -i 's!www-data!root!g' $PHP_DIR/etc/php-fpm.conf										&& \
#addgroup -g 82 -S www-data && useradd -u 82 -D -S -G www-data www-data						&& \

EXPOSE 9000

CMD ["php-fpm","-F"]
