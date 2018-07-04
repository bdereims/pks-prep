#!/bin/bash

. ../env

NODE_ID=$(cat /proc/sys/kernel/random/uuid)
CERTIFICATE_ID="814a4424-bb97-47e1-a7ae-a78ced870dc3"

pi_request=$(cat <<END
  {
    "display_name": "$PI_NAME",
    "name": "$PI_NAME",
    "permission_group": "superusers",
    "certificate_id": "$CERTIFICATE_ID",
    "node_id": "$NODE_ID"
  }
END
)

curl -k -X POST \
"https://${NSX_MANAGER_IP}/api/v1/trust-management/principal-identities" \
-u "${ADMIN}:${PASSWORD}" \
-H 'content-type: application/json' \
-d "$pi_request"
