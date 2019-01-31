#!/bin/bash
#bdereims@vmware.com

. ../env

curl -s -k "https://${OPSMANAGER}/api/v0/setup" \
    -X POST \
    -H "Content-Type: application/json" \
    -d '{ "setup": {
    "decryption_passphrase": "${PASSWORD}",
    "decryption_passphrase_confirmation":"${PASSWORD}",
    "eula_accepted": "true",
    "identity_provider": "internal",
    "admin_user_name": "${ADMIN}",
    "admin_password": "${PASSWORD}",
    "admin_password_confirmation": "${PASSWORD}",
    "http_proxy": "",
    "https_proxy": "",
    "no_proxy": ""
  } }'
