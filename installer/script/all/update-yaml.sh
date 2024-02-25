#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: ./script.sh <key> <value> <path-to-docker-compose.yml>"
    exit 1
fi

# Assign the arguments to variables for better readability
key="$1"
value="$2"
file_path="$3"

# Update the value in the Docker Compose file
sed -i "s/\(${key}:\s*\).*/\1\"${value}\"/" "${file_path}"
