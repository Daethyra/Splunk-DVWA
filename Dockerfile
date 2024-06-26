FROM docker.io/library/php:8-apache

LABEL org.opencontainers.image.source=https://github.com/digininja/DVWA
LABEL org.opencontainers.image.description="DVWA pre-built image."
LABEL org.opencontainers.image.licenses="gpl-3.0"

WORKDIR /var/www/html

# https://www.php.net/manual/en/image.installation.php
RUN apt-get update \
 && apt-get upgrade -y \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev iputils-ping wget curl \
 && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-configure gd --with-jpeg --with-freetype \
 # Use pdo_sqlite instead of pdo_mysql if you want to use sqlite
 && docker-php-ext-install gd mysqli pdo pdo_mysql

COPY --chown=www-data:www-data . .
COPY --chown=www-data:www-data config/config.inc.php.dist config/config.inc.php

## https://docs.splunk.com/Documentation/Forwarder/9.2.1/Forwarder/Installanixuniversalforwarder
# Download and Install Splunk Universal Forwarder
RUN wget -O /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb "https://download.splunk.com/products/universalforwarder/releases/9.2.1/linux/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb" \
 # Installs Splunk Forwarder, which creates /opt/splunkforwarder, splunkfwd user and group
 && dpkg -i /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb \
 # Remove temporary files
 && rm -f /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb \
 # Change ownership of /opt/splunkforwarder
 && chown -R splunkfwd:splunkfwd /opt/splunkforwarder

# Switch to Splunk user, set environment variables and configure PATH
USER splunkfwd
ENV SPLUNK_HOME=/opt/splunkforwarder
ENV PATH=${SPLUNK_HOME}/bin:$PATH

# Configure Forwarder's monitoring
## Remember to overwrite DVWA's config folder with this repository's config folder before building!
COPY --chown=splunkfwd:splunkfwd config/*.conf /opt/splunkforwarder/etc/system/local/

# Switch to Root to let DVWA finish its build as normal
USER root