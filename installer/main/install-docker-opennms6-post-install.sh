#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


##
## Logging
##


echo ""
echo "START - Docker\OpenNMS - Post Installation Procedures"
echo ""


# start the docker container
cd $OPENNMS_CORE_DIR
docker-compose up -d


# Wait for docker container to come online
while [ "`docker inspect -f {{.State.Health.Status}} opennms-core`" != "healthy" ]; do clear; echo "Waiting for first boot..."; docker ps; sleep 2; done


##
## Logging
##


clear
echo ""
echo "Applying custom activemq, mail, ... configuration..."
echo ""


cd $OPENNMS_INSTALLER_DIR

# Create users
( . script/api/opennms-accounts-create.sh )

# Create requisitions
( . script/api/opennms-requisitions-create.sh )

# Set javamail-configuration.properties
cp $OPENNMS_INSTALLER_DIR/conf/core/javamail-configuration-template.properties $OPENNMS_CORE_DIR/opennms-etc/javamail-configuration.properties

# Set javamail-configuration.xml
cp $OPENNMS_INSTALLER_DIR/conf/core/javamail-configuration-template.xml $OPENNMS_CORE_DIR/opennms-etc/javamail-configuration.xml

# Activate ActiveMQ
#   Enable ActiveMQ (allows minion communication)
#   vi /opt/opennms/opennms-etc/opennms-activemq.xml
#   uncomment: <!-- <transportConnector name="openwire" uri= ...-->
cp $OPENNMS_INSTALLER_DIR/conf/core/opennms-activemq-template.xml $OPENNMS_CORE_DIR/opennms-etc/opennms-activemq.xml

# Restart the docker container
cd /opt/apps/opennms/opennms-core
docker-compose restart

# Wait for docker container to come online
while [ "`docker inspect -f {{.State.Health.Status}} opennms-core`" != "healthy" ]; do clear; echo "Waiting for final boot..."; docker ps; sleep 2; done


##
## Logging
##


echo ""
echo "END - Docker\OpenNMS - Post Installation Procedures"
echo ""


## 
## Final Notes
##

echo ""
echo "You must enter the credentials for the minion."
echo "You can do so by running the following command per minion: "
echo ""
echo "# Set the keystore: "
echo "docker-compose run -v \$(pwd)/keystore:/keystore \${PWD##*/} -s"
echo "# Start the container: "
echo "docker-compose up -d"