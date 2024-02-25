#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024

docker exec -it opennms-core-postgres psql -U postgres opennms

# SHOW max_connections;