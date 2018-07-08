#!/bin/bash

. ./env

function upload_product {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-product --product ${1} 
}

function upload_stemcell {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-stemcell --stemcell ${1} 
}

#for FILE in $( ls ${BITS}/PKS/*.pivotal ); do
#	upload_product ${FILE}
#done

#upload_product ${BITS}/PKS/pivotal-container-service-1.1.0-build.311.pivotal 
#upload_product ${BITS}/PKS/harbor-container-registry-1.5.1-build.7.pivotal
upload_stemcell ${BITS}/PKS/bosh-stemcell-3586.24-vsphere-esxi-ubuntu-trusty-go_agent.tgz
#upload_stemcell ${BITS}/PKS/bosh-stemcell-3468.30-vsphere-esxi-ubuntu-trusty-go_agent.tgz

