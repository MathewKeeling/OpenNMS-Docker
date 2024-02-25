#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


##
## Logging
##
echo ""
echo "START - Docker\OpenNMS - Customization"
echo ""


##
## Customize Core Files
##

# Replace OpenNMS/Core Image Metadata
# Image
sed -i -e "s|OPENNMS_CORE_IMAGE|$OPENNMS_CORE_IMAGE|g" $OPENNMS_CORE_DIR/docker-compose.yaml
# Image Tag
sed -i -e "s|OPENNMS_CORE_TAG|$OPENNMS_CORE_TAG|g" $OPENNMS_CORE_DIR/docker-compose.yaml
# Container Name

# Web Portal URL & Port
sed -i -e "s|OPENNMS_CORE_WEB_FQDN|$OPENNMS_CORE_WEB_FQDN|g" $OPENNMS_CORE_DIR/docker-compose.yaml
sed -i -e "s|OPENNMS_CORE_WEB_PORT|$OPENNMS_CORE_WEB_PORT|g" $OPENNMS_CORE_DIR/docker-compose.yaml

# Replace Postgres Image Metadata
# Replace OpenNMS/Minion(s) Image Metadata
# Image
sed -i -e "s|POSTGRES_IMAGE|$POSTGRES_IMAGE|g" $OPENNMS_CORE_DIR/docker-compose.yaml
# Image Tag
sed -i -e "s|POSTGRES_TAG|$POSTGRES_TAG|g" $OPENNMS_CORE_DIR/docker-compose.yaml


##
## Customize Minion Files
##

OPENNMS_MINION_INDEX=0
for minion_name in "${OPENNMS_MINION_NAMES_ARR[@]}"
    do
        # Minion Index Increment
        OPENNMS_MINION_INDEX=$(($OPENNMS_MINION_INDEX + 1))
        # Local Variables
        opennms_minion_base_dir=$OPENNMS_ROOT_DIR/opennms-minion-$minion_name
        opennms_minion_container_dir=$OPENNMS_ROOT_DIR/opennms-minion-$minion_name/opt-minion

        # Customize docker-compose.yaml
        # Replace OpenNMS/Minion(s) Image Metadata
        # Image
        sed -i -e "s|OPENNMS_MINION_IMAGE|$OPENNMS_MINION_IMAGE|g" $opennms_minion_base_dir/docker-compose.yaml
        # Image Tag
        sed -i -e "s|OPENNMS_MINION_TAG|$OPENNMS_MINION_TAG|g" $opennms_minion_base_dir/docker-compose.yaml
        # Minion Name
        sed -i -e "s|OPENNMS_MINION_NAME|$minion_name|g" $opennms_minion_base_dir/docker-compose.yaml
        # Port Index
        sed -i -e "s|OPENNMS_MINION_INDEX|$OPENNMS_MINION_INDEX|g" $opennms_minion_base_dir/docker-compose.yaml

        # Customize minion-config.yaml
        # Web Portal URL & Port
        sed -i -e "s|OPENNMS_CORE_WEB_FQDN|$OPENNMS_CORE_WEB_FQDN|g" $opennms_minion_base_dir/minion-config.yaml
        sed -i -e "s|OPENNMS_CORE_WEB_MINION_PORT|$OPENNMS_CORE_WEB_MINION_PORT|g" $opennms_minion_base_dir/minion-config.yaml
        # Location
        sed -i -e "s|OPENNMS_LOCATION|$OPENNMS_LOCATION|g" $opennms_minion_base_dir/minion-config.yaml
        # Minion Name
        sed -i -e "s|OPENNMS_MINION_NAME|$minion_name|g" $opennms_minion_base_dir/minion-config.yaml
                
    done


##
## Finalizing
##

# Start OpenNMS

# Wait for Healthy

# Stop OpenNMS


##
## Logging
##
echo ""
echo "END - Docker\OpenNMS - Customization"
echo ""


##
## Pass off to the configuration script
##

#   As a subshell, it cannot overwrite variables in the principle script.
cd $OPENNMS_INSTALLER_DIR/main
( . install-docker-opennms3-configuration.sh )