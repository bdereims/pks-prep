#!/bin/bash

# get download env
source define_download_version_env

if [ $APIREFRESHTOKEN = "<insert-refresh-token-here>" ]
then
    echo "Update APIREFRESHTOKEN value in set_env before running it"
    exit 1
fi

# pks cli
pivnet login --api-token=$APIREFRESHTOKEN
PKSFileID=`pivnet pfs -p pivotal-container-service -r $PKSRELEASE | grep 'PKS CLI - Linux' | awk '{ print $2}'`
pivnet download-product-files -p pivotal-container-service -r $PKSRELEASE -i $PKSFileID

mv pks-linux-amd64* pks 
sudo chown root:root pks
sudo chmod +x pks
sudo cp pks ${BINDIR}/pks

# ops manager for vsphere
OpsmanFileId=`pivnet pfs -p ops-manager -r $OPSMANRELEASE | grep 'pcf-vsphere' | awk '{ print $2 }'`
pivnet accept-eula -p ops-manager -r $OPSMANRELEASE
pivnet download-product-files -p ops-manager -r $OPSMANRELEASE -i $OpsmanFileId
OpsmanFileName=`ls pcf-vsphere-*`
mv $OpsmanFileName $BITSDIR$PKSFOLDER
echo "export OpsmanFileName="$BITSDIR$PKSFOLDER"/"$OpsmanFileName > software_filenames.env

# pks tile
PKSFileID=`pivnet pfs -p pivotal-container-service -r $PKSRELEASE | grep pivotal-container-service-$PKSRELEASE | awk '{ print $2 }'`
pivnet accept-eula -p pivotal-container-service -r $PKSRELEASE
pivnet download-product-files -p pivotal-container-service -r $PKSRELEASE -i $PKSFileID
PKSFileName=`ls pivotal-container-service-*`
mv $PKSFileName $BITSDIR$PKSFOLDER
echo "export PKSFileName="$BITSDIR$PKSFOLDER"/"$PKSFileName > software_filenames.env

#pks stemcell
StemcellFileId=`pivnet pfs -p stemcells -r $STEMCELLRELEASE | grep 'vsphere' | awk '{ print $2 }'`
pivnet accept-eula -p stemcells -r $STEMCELLRELEASE
pivnet download-product-files -p stemcells -r $STEMCELLRELEASE -i $StemcellFileId
StemcellFileName=`ls bosh-stemcell-*`
mv $StemcellFileName $BITSDIR$PKSFOLDER
echo "export StemcellFileName="$BITSDIR$PKSFOLDER"/"$StemcellFileName > software_filenames.env

#Harbor Tile
HarborFileId=`pivnet pfs -p harbor-container-registry -r $HARBORRELEASE --format=json | jq -r '.[] | select (.file_type | contains("Software")) | .id'`
pivnet accept-eula -p harbor-container-registry -r $HARBORRELEASE
pivnet download-product-files -p harbor-container-registry -r $HARBORRELEASE -i $HarborFileId
HarborFileName=`ls harbor-container-registry*`
mv $HarborFileName $BITSDIR$PKSFOLDER
echo "export HarborFileName="$BITSDIR$PKSFOLDER"/"$HarborFileName > software_filenames.env

#pks Xenial stemcell
StemcellXenialFileId=`pivnet pfs -p stemcells-ubuntu-xenial -r $STEMCELLXENIALRELEASE | grep 'vsphere' | awk '{ print $2 }'`
pivnet accept-eula -p stemcells-ubuntu-xenial -r $STEMCELLXENIALRELEASE
pivnet download-product-files -p stemcells-ubuntu-xenial -r $STEMCELLXENIALRELEASE -i $StemcellXenialFileId
StemcellXenialFileName=`ls bosh-stemcell*xenial*`
mv $StemcellFileName $BITSDIR$PKSFOLDER
echo "export StemcellXenialFileName="$BITSDIR$PKSFOLDER"/"$StemcellXenialFileName > software_filenames.env