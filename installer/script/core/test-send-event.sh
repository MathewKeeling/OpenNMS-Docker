#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


# This script sends a test event.
# This is useful when troubleshooting notification troubles.

docker exec opennms /bin/bash -c "/opt/opennms/bin/send-event.pl uei.opennms.org/nodes/nodeDown -n 1"