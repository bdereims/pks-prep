#!/bin/bash

. ./env

function upload {
	om -t https://${OPSMANAGER} -u "admin" -p "VMware1!" -k upload-product --product ${1} 
}

for FILE in $( ls ${BITS}/PKS/*.pivotal ); do
	upload ${FILE}
done

om -t https://${OPSMANAGER} -u "admin" -p "VMware1!" upload-stemcell --stemcell /data/BITS/PKS/bosh-stemcell-3468.30-vsphere-esxi-ubuntu-trusty-go_agent.tgz
