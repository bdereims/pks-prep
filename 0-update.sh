#!/bin/sh
#bdereims@vmware.com
#Only tested on Ubuntu 16.04 LTS

BINDIR=/usr/local/bin
BOSHRELEASE=2.0.48
HELMRELEASE=2.8.1

sudo apt-get update ; apt-get upgrade
sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3

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

# helm
curl -LO https://kubernetes-helm.storage.googleapis.com/helm-v${HELMRELEASE}-linux-amd64.tar.gz
tar xvzf helm-v${HELMRELEASE}-linux-amd64.tar.gz linux-amd64/helm
chmod +x linux-amd64/helm
sudo cp linux-amd64/helm ${BINDIR}/helm
rm -fr linux-amd64
rm helm-v${HELMRELEASE}-linux-amd64.tar.gz

# pks
sudo chown root:root pks
sudo chmod +x pks
sudo cp pks ${BINDIR}/pks
