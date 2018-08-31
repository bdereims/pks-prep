#!/bin/bash

. ./env

function upload_product {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-product --product ${1} 
}

function upload_stemcell {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-stemcell --stemcell ${1} 
}

rm -fr /tmp/*
upload_product ${BITS}/PKS/pivotal-container-service-1.1.4-build.5.pivotal
upload_product ${BITS}/PKS/harbor-container-registry-1.5.2-build.8.pivotal
upload_stemcell ${BITS}/PKS/bosh-stemcell-3586.27-vsphere-esxi-ubuntu-trusty-go_agent.tgz
upload_stemcell ${BITS}/PKS/bosh-stemcell-3468.42-vsphere-esxi-ubuntu-trusty-go_agent.tgz
