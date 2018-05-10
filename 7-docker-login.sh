#!/bin/bash

. ./env

### Copy from Harbor VM those files /data/cert/server.*
### Rename server.crt to server.cert

CERTS=/etc/docker/certs.d/${REG_FQDN}
sudo mkdir -p ${CERTS} 
sudo cp ca.crt server.* ${CERTS}/.
mkdir -p ~/.docker/tls/${REG_FQDN}\:4443
cp ${CERTS}/* ~/.docker/tls/${REG_FQDN}\:4443/.

sudo systemctl restart docker
#docker login ${REG_FQDN} -u ${ADMIN} -p ${ADMIN_PASSWORD}
docker login ${REG_FQDN} -u admin -p ${ADMIN_PASSWORD}
