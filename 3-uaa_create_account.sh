#!/bin/bash

. ./env

GUID=$(om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/v0/deployed/products -s | jq '.[] | select(.installation_name | contains("pivotal-container-service"))  | .guid' | tr -d '""')
ADMIN_SECRET=$(om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/v0/deployed/products/${GUID}/credentials/.properties.pks_uaa_management_admin_client -s | jq '.credential.value.secret' | tr -d '""')

uaac target https://${UAA_FQDN}:8443 --skip-ssl-validation
uaac token client get admin -s "${ADMIN_SECRET}"
uaac user delete vmware 
uaac user delete demo 
uaac user add vmware --emails vmware@${PKS_FQDN} -p ${PASSWORD} 
uaac user add demo --emails demo@${PKS_FQDN} -p ${PASSWORD} 
uaac member add pks.clusters.admin vmware 
uaac member add pks.clusters.manage demo 
