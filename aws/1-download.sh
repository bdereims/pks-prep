#!/bin/bash
#bdereims@vmware.comn

pivnet login --api-token "${PIVNET_TOKEN}" 

pivnet download-product-files --product-slug='ops-manager' --release-version='2.6.12' --product-file-id=506768

pivnet download-product-files --product-slug='pivotal-container-service' --release-version='1.6.0-beta-1' --product-file-id=516053
pivnet download-product-files --product-slug='pivotal-container-service' --release-version='1.6.0-beta-1' --product-file-id=516044
pivnet download-product-files --product-slug='pivotal-container-service' --release-version='1.6.0-beta-1' --product-file-id=518444
pivnet download-product-files --product-slug='stemcells-ubuntu-xenial' --release-version='456.30' --product-file-id=503791

pivnet download-product-files --product-slug='harbor-container-registry' --release-version='1.8.4' --product-file-id=509549
pivnet download-product-files --product-slug='stemcells-ubuntu-xenial' --release-version='250.116' --product-file-id=503790

pivnet download-product-files --product-slug='elastic-runtime' --release-version='2.6.8' --product-file-id=494965
