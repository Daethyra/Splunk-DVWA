#!/bin/bash

# Reusable variables
INSTALL="Splunk Forwarder Installation:"
ENV="Configuring Environment Variables:"
CONF_MON="Configuring Monitor:"
BEGIN="BEGIN"
DONE="DONE"
COMPLETE="COMPLETE"

# Create Splunk user role and change $SPLUNK_HOME ownership
useradd -m splunkfwd
groupadd splunkfwd
chown -R splunkfwd:splunkfwd $SPLUNK_HOME

# Install Splunk Forwarder
echo $INSTALL $BEGIN
dpkg -i /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb
echo $INSTALL $DONE

# Switch to splunkfwd user and set $SPLUNK_HOME
su splunkfwd
echo $ENV $BEGIN
export SPLUNK_HOME=/opt/splunkforwarder >> ~/.profile
echo $ENV "SPLUNK_HOME" $DONE

# Add Splunk bin to PATH
export PATH=$SPLUNK_HOME/bin:$PATH
echo $ENV "splunk bin" $COMPLETE

# Configure Forwarder settings
echo $CONF_MON $BEGIN

# Copy all config files
cp /tmp/config/*.conf $SPLUNK_HOME/etc/system/local/

# Start Splunk
$SPLUNK_HOME/bin/splunk start --accept-license

# Finish
echo $INSTALL $COMPLETE