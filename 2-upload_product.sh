#!/bin/bash

. ./env

function upload_product {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-product --product ${1} 
}

function upload_stemcell {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-stemcell --stemcell ${1} 
}

om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" configure-authentication --decryption-passphrase ${PASSWORD} --password ${PASSWORD} --username ${ADMIN}

rm -fr /tmp/* 2>&1 > /dev/null

upload_product ${BITS}/PKS/pivotal-container-service-1.4.0-build.31.pivotal
upload_product ${BITS}/PKS/harbor-container-registry-1.7.5-build.11.pivotal
upload_stemcell ${BITS}/PKS/bosh-stemcell-250.25-vsphere-esxi-ubuntu-xenial-go_agent.tgz
