#!/bin/bash
#bdereims@vmware.com
#Only tested on Ubuntu 16.04/18.04 LTS

# source define_download_version_env
source define_download_version_env

#checking and creating BITSDIR if needed
if [[ ! -e $BITSDIR ]]; then
    mkdir $BITSDIR
fi

sudo add-apt-repository universe
sudo apt-get update ; sudo apt-get -y upgrade
sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 sshpass jq dnsmasq iperf3 sshpass ipcalc
sudo apt-get npm
sudo npm install -g npm

# vwm-cli - requires nodejs >=8
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install vmw-cli --global

# uuac
sudo gem install cf-uaac

# kubectl
#curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
#chmod +x kubectl
#sudo cp kubectl $BINDIR/kubectl
#rm kubectl

# bosh
curl -LO https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSHRELEASE}/bosh-cli-${BOSHRELEASE}-linux-amd64 
sudo cp bosh-cli-${BOSHRELEASE}-linux-amd64 ${BINDIR}/bosh
sudo chmod ugo+x ${BINDIR}/bosh 
rm bosh-cli-${BOSHRELEASE}-linux-amd64

# om
curl -LO https://github.com/pivotal-cf/om/releases/download/${OMRELEASE}/om-linux-${OMRELEASE}
sudo chown root om-linux-${OMRELEASE}
sudo chmod ugo+x om-linux-${OMRELEASE}
sudo mv om-linux-${OMRELEASE} ${BINDIR}/om

# helm
#curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v${HELMRELEASE}-linux-amd64.tar.gz
#tar xvzf helm-v${HELMRELEASE}-linux-amd64.tar.gz linux-amd64/helm
#chmod +x linux-amd64/helm
#sudo cp linux-amd64/helm ${BINDIR}/helm
#rm -fr linux-amd64
#rm helm-v${HELMRELEASE}-linux-amd64.tar.gz

# pivnet cli
curl -LO https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNETRELEASE}/pivnet-linux-amd64-${PIVNETRELEASE}

sudo chown root pivnet-linux-amd64-${PIVNETRELEASE}
sudo chmod ugo+x pivnet-linux-amd64-${PIVNETRELEASE}
sudo mv pivnet-linux-amd64-${PIVNETRELEASE} ${BINDIR}/pivnet
