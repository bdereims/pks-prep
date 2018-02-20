#!/bin/bash

. ./env

# USER : director
# PASSWD : https://OPS-MANAGER-FQDN/api/v0/deployed/director/credentials/director_credentials
bosh alias-env pks -e ${DIRECTOR} --ca-cert ca.crt
bosh -e pks log-in
