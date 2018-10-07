#!/bin/sh
#bdereims@vmware.com
#Only tested on Ubuntu 16.04/18.04 LTS

#BINDIR=/usr/local/bin
#BOSHRELEASE=5.3.1
#HELMRELEASE=2.11.0
#OMRELEASE=0.41.0
#PIVNETRELEASE=0.0.54
#APIREFRESHTOKEN="<insert-refresh-token-here>"
#BITSDIR=/data/bits
#OPSMANRELEASE=2.2.7
#PKSRELEASE=1.1.5
#STEMCELLRELEASE=3586.36

# source set_env
. set_env

if [ $APIREFRESHTOKEN = "<insert-refresh-token-here>" ]
then
    echo "Update APIREFRESHTOKEN value in set_env before running it"
    exit 1
fi

if [ $VMWUSER = '<username>' ]
then
    echo "Update VMWUSER value in set_env before running it"
    exit 1
fi

if [ $VMWPASS = '<password>' ]
then
    echo "Update VMWPASS value in set_env before running it"
    exit 1
fi


#checking and creating BITSDIR if needed
if [[ ! -e $BITSDIR ]]; then
    mkdir $BITSDIR
fi

sudo apt-get update ; sudo apt-get upgrade
sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 sshpass jq dnsmasq iperf3 npm

# vwm-cli - requires nodejs >=8
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install vmw-cli --global



# uuac
sudo gem install cf-uaac

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo cp kubectl $BINDIR/kubectl
rm kubectl

# bosh
curl -LO https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSHRELEASE}-linux-amd64
sudo cp bosh-cli-${BOSHRELEASE}-linux-amd64 ${BINDIR}/bosh
sudo chmod ugo+x ${BINDIR}/bosh 
rm bosh-cli-${BOSHRELEASE}-linux-amd64

# om
curl -LO https://github.com/pivotal-cf/om/releases/download/${OMRELEASE}/om-linux
sudo chown root om-linux
sudo chmod ugo+x om-linux
sudo mv om-linux ${BINDIR}/om

# helm
curl -LO https://kubernetes-helm.storage.googleapis.com/helm-v${HELMRELEASE}-linux-amd64.tar.gz
tar xvzf helm-v${HELMRELEASE}-linux-amd64.tar.gz linux-amd64/helm
chmod +x linux-amd64/helm
sudo cp linux-amd64/helm ${BINDIR}/helm
rm -fr linux-amd64
rm helm-v${HELMRELEASE}-linux-amd64.tar.gz

# pivnet cli
curl -LO https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNETRELEASE}/pivnet-linux-amd64-${PIVNETRELEASE}

sudo chown root pivnet-linux-amd64-${PIVNETRELEASE}
sudo chmod ugo+x pivnet-linux-amd64-${PIVNETRELEASE}
sudo mv pivnet-linux-amd64-${PIVNETRELEASE} ${BINDIR}/pivnet

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

# pks tile
PKSFileID=`pivnet pfs -p pivotal-container-service -r $PKSRELEASE | grep pivotal-container-service-$PKSRELEASE | awk '{ print $2 }'`
pivnet accept-eula -p pivotal-container-service -r $PKSRELEASE
pivnet download-product-files -p pivotal-container-service -r $PKSRELEASE -i $PKSFileID

#pks stemcell
StemcellFileId=`pivnet pfs -p stemcells -r $STEMCELLRELEASE | grep 'vsphere' | awk '{ print $2 }'`
pivnet accept-eula -p stemcells -r $STEMCELLRELEASE
pivnet download-product-files -p stemcells -r $STEMCELLRELEASE -i $StemcellFileId

