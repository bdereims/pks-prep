#!/bin/bash

. ../env

./notary -s https://${REG_FQDN}:4443 --tlscacert ~/.docker/tls/${REG_FQDN}\:4443/ca.crt -d ~/.docker/trust list ${REG_FQDN}/${1}
