#!/bin/bash

. ./env

function upload_product {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-product --product ${1} 
}

function upload_stemcell {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-stemcell --stemcell ${1} 
}

rm -fr /tmp/* 2>&1 > /dev/null
upload_product ${BITS}/PKS/pivotal-container-service-1.2.4-build.6.pivotal
upload_product ${BITS}/PKS/harbor-container-registry-1.6.0-build.35.pivotal
upload_stemcell ${BITS}/PKS/bosh-stemcell-97.41-vsphere-esxi-ubuntu-xenial-go_agent.tgz
