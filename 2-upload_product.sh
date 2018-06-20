#!/bin/bash

. ./env

function upload_product {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${ADMIN_PASSWORD}" upload-product --product ${1} 
}

function upload_stemcell {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${ADMIN_PASSWORD}" upload-stemcell --stemcell ${1} 
}

#for FILE in $( ls ${BITS}/PKS/*.pivotal ); do
#	upload_product ${FILE}
#done

upload_product ${BITS}/PKS/pivotal-container-service-1.0.4-build.5.pivotal 
upload_product ${BITS}/PKS/harbor-container-registry-1.4.2-build.14.pivotal
upload_stemcell ${BITS}/PKS/bosh-stemcell-3468.42-vsphere-esxi-ubuntu-trusty-go_agent.tgz
