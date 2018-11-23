#!/bin/bash

. ./env

function upload_product {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-product --product ${1} 
}

function upload_stemcell {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-stemcell --stemcell ${1} 
}

rm -fr /tmp/*
upload_product ${BITS}/PKS/pivotal-container-service-1.2.2-build.3.pivotal
upload_product ${BITS}/PKS/harbor-container-registry-1.6.0-build.35.pivotal
#upload_stemcell ${BITS}/PKS/bosh-stemcell-97.17-vsphere-esxi-ubuntu-xenial-go_agent.tgz
