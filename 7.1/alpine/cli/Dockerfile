ARG PHP_MOD=cli
ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}-${PHP_MOD}-alpine
WORKDIR "/public_html"

RUN apk update \
    && apk upgrade --update

ARG UID=1000
ARG GID=1000
RUN deluser --remove-home www-data
RUN addgroup -g ${GID} www-data \
  && adduser -u ${UID} -G www-data -s /bin/sh -S www-data

RUN docker-php-ext-install pdo_mysql
RUN set -xe \
	&& apk add --no-cache libxml2-dev
RUN docker-php-ext-install soap
RUN set -xe \
  && apk add --no-cache icu-dev
RUN docker-php-ext-install intl
RUN set -xe \
  && apk add --no-cache libxslt-dev
RUN docker-php-ext-install xsl
RUN docker-php-ext-install zip
RUN docker-php-ext-install opcache
RUN docker-php-ext-install bcmath

## install gd
RUN apk add \
			--no-cache \
			freetype \
			libpng \
			libjpeg-turbo \
			freetype-dev \
			libpng-dev \
			libjpeg-turbo-dev\
		&& docker-php-ext-configure gd \
			--with-gd \
			--with-freetype-dir=/usr/include/ \
			--with-png-dir=/usr/include/ \
			--with-jpeg-dir=/usr/include/ \
		&& docker-php-ext-install gd

RUN  set -xe \
  && apk add \
			--no-cache \
			libmcrypt-dev \
			libltdl \
		&& docker-php-ext-configure mcrypt \
			--with-mcrypt \
		&& docker-php-ext-install mcrypt

RUN  set -xe \
  && apk add --no-cache \
      autoconf \
      gcc g++ make

RUN pecl install xdebug-2.6.0 \
  && docker-php-ext-enable xdebug

ENV COMPOSER_HOME=/home/.composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
RUN if [ ! -d ${COMPOSER_HOME} ]; then \
        mkdir -p ${COMPOSER_HOME}; \
    fi; \
    chown ${UID}:${GID} -R ${COMPOSER_HOME}

# Install n98
RUN curl -L -o n98-magerun2.phar https://files.magerun.net/n98-magerun2.phar \
  && mv n98-magerun2.phar /usr/local/bin/mage \
  && chmod +x /usr/local/bin/mage

COPY mage-install /usr/local/bin/mage-install
RUN chmod +x /usr/local/bin/mage-install

USER www-data
