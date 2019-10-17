#!/bin/bash -e
#bdereims@vmware.com

git pull
cd containers
make build-all 

exit 0
