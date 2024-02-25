#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


##
## Logging
##
echo ""
echo "START - Docker\OpenNMS - Metadata"
echo ""


##
## Finalizing
##


##
## Logging
##
echo ""
echo "END - Docker\OpenNMS - Metadata"
echo ""

cd $OPENNMS_INSTALLER_DIR/main
( . install-docker-opennms6-post-install.sh )