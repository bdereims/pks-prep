#!/bin/bash

. ../env

#om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/v0/staged/products/product-type1-guid/networks_and_azs 
GUID_BOSH=$( om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/v0/staged/products | jq ".[] | select(.type==\"p-bosh\") | .guid" | sed -e "s/\"//g" )

echo ${GUID_BOSH}

om -t https://${OPSMANAGER} -u "${ADMIN}" -p "${PASSWORD}" -k curl -p /api/v0/staged/products/${GUID_BOSH}/networks_and_azs
