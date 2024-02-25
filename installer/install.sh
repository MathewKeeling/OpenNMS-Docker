#/bin/bash
cd /opt/depot/installers/OPENNMS/main

# Load Localization
. install-docker-opennms0-localization.sh

# Start Installer
( . install-docker-opennms1-initialization.sh )