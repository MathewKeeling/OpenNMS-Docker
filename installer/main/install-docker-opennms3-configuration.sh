#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


##
## Logging
##
echo ""
echo "START - Docker\OpenNMS - Configuration"
echo ""


##
## Enable Services
##

# Enable Syslog
# Enable Syslogd (On the core, if you are merely running the core)
# vi /opt/opennms/opennms-etc/service-configuration.xml
# <service enabled="true">

# Configure javamail-configuration-template.properties
sed -i -e "s|OPENNMS_RELAY_HOST_FQDN|$OPENNMS_RELAY_HOST_FQDN|g" $OPENNMS_INSTALLER_DIR/conf/core/javamail-configuration-template.properties
sed -i -e "s|OPENNMS_RELAY_SERVER_PORT|$OPENNMS_RELAY_SERVER_PORT|g" $OPENNMS_INSTALLER_DIR/conf/core/javamail-configuration-template.properties
sed -i -e "s|OPENNMS_FROM_ADDRESS|$OPENNMS_FROM_ADDRESS|g" $OPENNMS_INSTALLER_DIR/conf/core/javamail-configuration-template.properties

# Configure javamail-configuration-template.xml
# tbd



##
## Finalizing
##


##
## Logging
##
echo ""
echo "END - Docker\OpenNMS - Configuration"
echo ""


cd $OPENNMS_INSTALLER_DIR/main
( . install-docker-opennms4-inventory.sh )