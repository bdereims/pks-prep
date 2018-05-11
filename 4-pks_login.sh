#!/bin/sh

. ./env

pks login -a https://${UAA_FQDN}:9021 -u ${ADMIN} -p ${ADMIN_PASSWORD} -k
