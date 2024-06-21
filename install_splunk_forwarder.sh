#!/bin/bash

# Reusable variables
INSTALL="Splunk Forwarder Installation:"
ENV="Configuring Environment Variables:"
CONF_MON="Configuring Monitor:"
BEGIN="BEGIN"
DONE="DONE"
COMPLETE="COMPLETE"

# Install Splunk Forwarder
echo $INSTALL $BEGIN
dpkg -i /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb
echo $INSTALL $DONE

# Configure Splunk Home
echo $ENV $BEGIN
export SPLUNK_HOME=/opt/splunkforwarder >> ~/.profile
echo $ENV "SPLUNK_HOME" $DONE

# Create Splunk User
useradd -m splunkfwd
groupadd splunkfwd

# Add Splunk bin to path
export PATH=$SPLUNK_HOME/bin:$PATH
mkdir $SPLUNK_HOME
echo $ENV $COMPLETE

# Create Splunk user role and change $SPLUNK_HOME ownership
useradd -m splunkfwd
groupadd splunkfwd
chown -R splunkfwd:splunkfwd $SPLUNK_HOME

# Start Splunk
$SPLUNK_HOME/bin/splunk start --accept-license

# Configure Forwarder settings
echo $CONF_MON $BEGIN

splunk add forward-server 127.0.0.1:9997
echo $CONF_MON "forward server" $DONE
splunk add monitor /var/log/apache2/access.log
echo $CONF_MON "apache access log" $DONE
splunk add monitor /var/log/apache2/error.log
echo $CONF_MON "apache error log" $DONE
splunk add monitor /var/log/mysql/error.log
echo $CONF_MON "mysql error log" $DONE
splunk add monitor /etc/shadow
echo $CONF_MON "shadow file" $DONE
splunk add tcp 80
echo $CONF_MON "tcp 80" $DONE
echo $CONF_MON $COMPLETE

# Finish
echo $INSTALL $COMPLETE