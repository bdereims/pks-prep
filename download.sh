#!/bin/bash

#https://shwrfr.com/nextcloud/index.php/s/bo3WKfNuO3H7uKE
#export PIVNET_TOKEN=...

function download {
	wget -O $1  --post-data="" --header="Authorization: Token $PIVNET_TOKEN" $2
}

download pcf-vsphere-2.1-build.214.ova https://network.pivotal.io/api/v2/products/ops-manager/releases/80416/product_files/116798/download 

download pivotal-container-service-1.0.3-build.15.pivotal https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/92793/product_files/130381/download

download kubectl-linux-amd64-v1.9.6 https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/92793/product_files/135944/download

#download pks-linux-amd64-1.0.2-build.12 https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/80995/product_files/117461/download

download bosh-stemcell-3468.30-vsphere-esxi-ubuntu-trusty-go_agent.tgz https://network.pivotal.io/api/v2/products/stemcells/releases/78078/product_files/114228/download
