#!/bin/bash

#export PIVNET_TOKEN=...

function download {
	wget -O $1  --post-data="" --header="Authorization: Token $PIVNET_TOKEN" $2
}

download pcf-vsphere-2.0-build.279.ova https://network.pivotal.io/api/v2/products/ops-manager/releases/80767/product_files/117195/download

download pivotal-container-service-1.0.2-build.62.pivotal https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/80995/product_files/117457/download

download kubectl-linux-amd64-v1.9.5 https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/80995/product_files/117455/download 

download pks-linux-amd64-1.0.2-build.12 https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/80995/product_files/117461/download

download bosh-stemcell-3468.30-vsphere-esxi-ubuntu-trusty-go_agent.tgz https://network.pivotal.io/api/v2/products/stemcells/releases/78078/product_files/114228/download
