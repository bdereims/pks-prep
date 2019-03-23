#!/bin/bash

. ./env

pks login -a https://${UAA_FQDN}:9021 -u vmware -p ${PASSWORD} -k
