#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024

# Admin Authorization
ADMIN_USER='admin'
ADMIN_PASS='admin'
BASIC_AUTH_TOKEN="Authorization: Basic $(echo -n "$ADMIN_USER:$ADMIN_PASS" | base64 -w 0)"

# Accounts to Create
for REQUISITION in "${OPENNMS_CORE_REQUISITIONS[@]}"
    do
        curl --request POST \
        --url http://opennms01.ad.contoso.com:8980/opennms/rest/requisitions \
        --header "$BASIC_AUTH_TOKEN" \
        --header 'Content-Type: application/xml' \
        --header 'User-Agent: insomnia/8.6.1' \
        --data "<model-import xmlns=\"http://xmlns.opennms.org/xsd/config/model-import\" foreign-source=\"$OPENNMS_LOCATION-$REQUISITION\"/>"
    done

