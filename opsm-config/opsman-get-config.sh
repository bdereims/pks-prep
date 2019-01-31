#!/bin/bash

. ../env

#om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/installation_settings | python -m json.tool > installsettings.json

. ./opsman-connect.sh 

curl -k "https://${OPSMANAGER}/api/installation_settings" -X GET -X GET -H "Authorization: Bearer ${TOKEN}" | python -m json.tool > installsettings.json
