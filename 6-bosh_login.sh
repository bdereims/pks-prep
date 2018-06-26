#!/bin/bash

. ./env

# USER : director
# PASSWD : https://OPS-MANAGER-FQDN/api/v0/deployed/director/credentials/director_credentials

PASSWD=$( om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/v0/deployed/director/credentials/director_credentials -s | jq '.[] | .value.password' | sed -e "s/\"//g" )

echo -e "director\n${PASSWD}" | bosh -e pks log-in
