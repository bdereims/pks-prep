#!/bin/bash

. ../env
REG_FQDN=harbor.pks-reg.gv
./notary -s https://${REG_FQDN}:4443 --tlscacert ~/.docker/tls/${REG_FQDN}\:4443/ca.crt -d ~/.docker/trust remove -p ${REG_FQDN}/${1} latest
