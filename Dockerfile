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
 && docker-php-ext-install gd mysqli pdo pdo_mysql \
 # Download the Splunk Universal Forwarder
 && wget -O /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb "https://download.splunk.com/products/universalforwarder/releases/9.2.1/linux/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb"

# Create Splunk user and group
RUN useradd -m splunkfwd \
 # Install Splunk Forwarder
 && dpkg -i /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb \
 # Change ownership of $SPLUNK_HOME
 && chown -R splunkfwd:splunkfwd /opt/splunkforwarder

# Switch to Splunk user, set environment variables and configure PATH
USER splunkfwd
ENV SPLUNK_HOME=/opt/splunkforwarder
ENV PATH=$SPLUNK_HOME/bin:$PATH

# Install custom Forwarder configurations
COPY --chown=splunkfwd:splunkfwd config/*.conf $SPLUNK_HOME/etc/system/local/

# Switch back to root before copying DVWA's files
USER root
COPY --chown=www-data:www-data . .
COPY --chown=www-data:www-data config/config.inc.php.dist config/config.inc.php