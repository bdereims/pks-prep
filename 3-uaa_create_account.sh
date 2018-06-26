#!/bin/sh

. ./env

uaac target https://${UAA_FQDN}:8443 --skip-ssl-validation
uaac token client get admin -s ${UAA_ADMIN_SECRET}
uaac user add ${ADMIN} --emails ${ADMIN}@${PKS_FQDN} -p ${PASSWORD} 
uaac member add pks.clusters.admin ${ADMIN} 
