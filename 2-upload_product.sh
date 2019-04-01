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
upload_product ${BITS}/PKS/pivotal-container-service-1.3.5-build.3.pivotal
upload_product ${BITS}/PKS/harbor-container-registry-1.7.4-build.42.pivotal
#upload_stemcell ${BITS}/PKS/bosh-stemcell-170.15-vsphere-esxi-ubuntu-xenial-go_agent.tgz
