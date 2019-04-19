ARG PHP_MOD=apache
ARG PHP_VERSION=7.3
FROM php:${PHP_VERSION}-${PHP_MOD}
WORKDIR "/public_html"

ARG UID=1000
ARG GID=1000

RUN usermod -u ${UID} www-data
RUN groupmod -g ${GID} www-data
RUN apt-get update

# Install php extension
# pdo, soap, intl, xsl, zip, opcache, bcmath
RUN apt-get install -y  \
  libxml2-dev \
  libxslt1-dev \
  libzip-dev

RUN docker-php-ext-install soap \
  && docker-php-ext-install pdo pdo_mysql \
  && docker-php-ext-install bcmath \
  && docker-php-ext-install zip \
  && docker-php-ext-install xsl \
  && docker-php-ext-install intl \
  && docker-php-ext-install mbstring

# install GD
RUN apt-get install -y libfreetype6-dev \
       libjpeg62-turbo-dev \
       libpng-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# install mcrypt
RUN apt-get install -y libmcrypt-dev
RUN pecl install mcrypt-1.0.1 \
  && docker-php-ext-enable mcrypt

# install xdebug
RUN pecl install xdebug-2.6.1 \
  && docker-php-ext-enable xdebug

# install composer
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


RUN a2enmod rewrite;

COPY ./php-entrypoint.sh /usr/local/bin/php-entrypoint.sh
RUN chmod +x /usr/local/bin/php-entrypoint.sh

ENTRYPOINT ["php-entrypoint.sh"]

USER www-data
EXPOSE 80
CMD ["apache2-foreground"]
