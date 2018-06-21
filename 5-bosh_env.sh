#!/bin/bash

. ./env

# USER : director
# PASSWD : https://OPS-MANAGER-FQDN/api/v0/deployed/director/credentials/director_credentials
rm -fr ~/.bosh

om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/v0/certificate_authorities -s | jq -r '.certificate_authorities | select(map(.active == true))[0] | .cert_pem' > ca.crt 

bosh alias-env pks -e ${DIRECTOR} --ca-cert ca.crt
