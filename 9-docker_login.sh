#!/bin/bash

. ./env

### Copy from Harbor VM those files /data/cert/server.*
### Rename server.crt to server.cert

cp server.crt server.cert
CERTS=/etc/docker/certs.d/${REG_FQDN}
sudo mkdir -p ${CERTS} 
sudo cp ca.crt server.* ${CERTS}/.
mkdir -p ~/.docker/tls/"${REG_FQDN}:4443"
sudo chown -R ${USER} ~/.docker/tls/* 

sudo systemctl restart docker
docker login ${REG_FQDN} -u ${ADMIN} -p ${PASSWORD}

# Create secret for pivate registry
kubectl create secret docker-registry regsecret --docker-server=https://${REG_FQDN} --docker-username=${ADMIN} --docker-password=${PASSWORD} --docker-email=${ADMIN}@${REG_FQDN}
