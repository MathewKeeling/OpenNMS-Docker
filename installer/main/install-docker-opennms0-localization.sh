#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


##
## Logging
##


echo ""
echo "START - Docker\OpenNMS - User"
echo ""


##
## Local Variables
##

echo ""
echo "Setting Environment Variables"
echo ""
# Host Environment Variables
APPS_ROOT_DIR="/opt/apps"
OPENNMS_ROOT_DIR="$APPS_ROOT_DIR/opennms"
APT_PACKAGE_DEPENENCIES_ARR=("docker.io" "docker-compose")
PRIMARY_USER=$(id -un 1000)
OPENNMS_INSTALLER_DIR="/opt/depot/installers/OPENNMS/installer"
OPENNMS_LOCATION="organization_name"
OPENNMS_HOSTNAME="opennms"
OPENNMS_DOMAIN="ad.contoso.com"
OPENNMS_DOMAIN_PUBLIC="contoso.com" # For sending emails
# OpenNMS/Core
OPENNMS_CORE_DIR="$OPENNMS_ROOT_DIR/opennms-core"
OPENNMS_CORE_DIR_SUBDIRS=("opennms-etc" "opennms-logs" "opennms-data" "scripts" "postgres-data")
OPENNMS_CORE_IMAGE="docker.io/opennms/horizon"
OPENNMS_CORE_REQUISITIONS=("core" "autodiscovery")
OPENNMS_CORE_TAG='32.0.0'
OPENNMS_CORE_UID=10001
OPENNMS_CORE_WEB_FQDN="$OPENNMS_HOSTNAME.$OPENNMS_DOMAIN"
OPENNMS_CORE_WEB_PORT=8980
OPENNMS_CORE_WEB_MINION_PORT=51616
# OpenNMS/Minion
OPENNMS_MINION_DIR_SUBDIRS=("keystore" "scripts")
OPENNMS_MINION_IMAGE="docker.io/opennms/minion"
OPENNMS_MINION_TAG='32.0.0'
OPENNMS_MINION_UID=10001
OPENNMS_MINION_COUNT=2
OPENNMS_MINION_NAMES_ARR=("autodiscovery" "core")
# OpenNMS/Core/Javamail
OPENNMS_RELAY_HOST_FQDN="postfix.$OPENNMS_DOMAIN"
OPENNMS_RELAY_SERVER_PORT=25
OPENNMS_FROM_ADDRESS="opennms@$OPENNMS_DOMAIN_PUBLIC"

# Postgres
POSTGRES_ROOT_DIR="$OPENNMS_ROOT_DIR/opennms-core/postgres-data"
POSTGRES_IMAGE="docker.io/postgres"
POSTGRES_TAG='14'
POSTGRES_UID="UNKNOWN"


##
## Logging
## 


echo ""
echo "END - Docker\OpenNMS - User Input"
echo ""