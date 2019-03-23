#!/bin/bash

#read deployment parameters
source ./env

#read software bits
source ./software_filenames.env


function upload_product {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-product --product ${1} 
}

function upload_stemcell {
	om -t https://${OPSMANAGER} -k -u "${ADMIN}" -p "${PASSWORD}" upload-stemcell --stemcell ${1} 
}


rm -fr /tmp/*

#upload PKS Tile
upload_product ${PKSFileName}
#upload trusty Stemcell
upload_stemcell ${StemcellFileName}

#upload Harbor tile
upload_product ${HarborFileName}
#upload Xenial Stemcell
upload_stemcell ${StemcellXenialFileName}

