#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024

# Admin Authorization
ADMIN_USER='admin'
ADMIN_PASS='admin'
BASIC_AUTH_TOKEN="Authorization: Basic $(echo -n "$ADMIN_USER:$ADMIN_PASS" | base64 -w 0)"

# Accounts to Create
ACCOUNTS=("minion")
ROLE='ROLE_MINION'

for ACCOUNT in "${ACCOUNTS[@]}"
    do
        curl --request POST \
        --url http://$OPENNMS_CORE_WEB_FQDN:8980/opennms/rest/users?hashPassword=true \
        --header "$BASIC_AUTH_TOKEN" \
        --header 'Content-Type: application/xml' \
        --header 'User-Agent: insomnia/8.6.1' \
        --data "<user>
            <user-id>$ACCOUNT</user-id>
            <full-name>$ACCOUNT</full-name>
            <password>$ACCOUNT</password>
            <role>$ROLE</role>
        </user>"
    done

