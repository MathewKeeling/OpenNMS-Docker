#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


##
## Logging
##
echo ""
echo "START - Docker\OpenNMS - Initialization"
echo ""


##
## Download/Install Dependencies
##

echo ""
echo ""
echo "Installing APT Packages"
echo ""
# Install Host Packages
for package in "${APT_PACKAGE_DEPENENCIES_ARR[@]}"; do apt install $package -y; done


echo ""
echo ""
echo "Pulling Docker Images: "
echo ""
# Docker: Pull Images
docker pull $OPENNMS_CORE_IMAGE:$OPENNMS_CORE_TAG
docker pull $OPENNMS_MINION_IMAGE:$OPENNMS_MINION_TAG
docker pull $POSTGRES_IMAGE:$POSTGRES_TAG


##
## Directory Creation
##

# Create Directories
mkdir -p $OPENNMS_ROOT_DIR
chown -R $PRIMARY_USER:$PRIMARY_USER $APPS_ROOT_DIR

# OpenNMS Core
for dir in "${OPENNMS_CORE_DIR_SUBDIRS[@]}"
    do
        mkdir -p $OPENNMS_CORE_DIR/$dir
    done

# OpenNMS Minion(s)
for minion_name in "${OPENNMS_MINION_NAMES_ARR[@]}"
    do
        # Define root directory for minion
        opennms_minion_dir=$OPENNMS_ROOT_DIR/opennms-minion-$minion_name
        
        for dir in "${OPENNMS_MINION_DIR_SUBDIRS[@]}"
            do
                # Make Directories
                mkdir -p $opennms_minion_dir/$dir
            done
    done


##
## Docker: OpenNMS-Core
##

# Copy Base Files
cp $OPENNMS_INSTALLER_DIR/conf/core/docker-compose-template.yaml $OPENNMS_CORE_DIR/docker-compose.yaml
# Copy Management Scripts
cp $OPENNMS_INSTALLER_DIR/script/all/* $OPENNMS_CORE_DIR/scripts
cp $OPENNMS_INSTALLER_DIR/script/core/* $OPENNMS_CORE_DIR/scripts

# Change Permissions for OpenNMS Core
chown -R $OPENNMS_CORE_UID:$OPENNMS_CORE_UID $OPENNMS_CORE_DIR
chmod +x $OPENNMS_CORE_DIR/scripts/*.sh


##
## Docker: OpenNMS-Minion(s)
##

# Copy Base Files
for minion_name in "${OPENNMS_MINION_NAMES_ARR[@]}"
    do
        opennms_minion_dir=$OPENNMS_ROOT_DIR/opennms-minion-$minion_name
        # Copy Base Files
        cp $OPENNMS_INSTALLER_DIR/conf/minion/docker-compose-template.yaml $opennms_minion_dir/docker-compose.yaml
        cp $OPENNMS_INSTALLER_DIR/conf/minion/minion-config-template.yaml $opennms_minion_dir/minion-config.yaml
        # Copy Management Scripts
        cp $OPENNMS_INSTALLER_DIR/script/all/* $opennms_minion_dir/scripts
        cp $OPENNMS_INSTALLER_DIR/script/minion/* $opennms_minion_dir/scripts
    done

# Change Permissions for OpenNMS Minion(s)
for minion_name in "${OPENNMS_MINION_NAMES_ARR[@]}"
    do
        opennms_minion_dir=$OPENNMS_ROOT_DIR/opennms-minion-$minion_name
        chown -R $OPENNMS_MINION_UID:$OPENNMS_MINION_UID $opennms_minion_dir/keystore
        chown -R $OPENNMS_MINION_UID:$OPENNMS_MINION_UID $opennms_minion_dir
        chmod +x $opennms_minion_dir/scripts/*.sh
    done


##
## Logging
## 
echo ""
echo "END - Docker\OpenNMS - Initialization"
echo ""


##
## Pass off to the customization script
##

# As a subshell, it cannot overwrite variables in the principle script.
cd $OPENNMS_INSTALLER_DIR/main
( . install-docker-opennms2-customization.sh )