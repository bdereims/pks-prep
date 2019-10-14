#!/bin/bash
#bdereims@vmware.com

helm install stable/rocketchat --set persistence.StorageClass=standard,mongodb.mongodbPassword=password,mongodb.mongodbRootPassword=password,host=ingress-giving-snipe.shwrfr.com,ingress.enabled=true stable/rocketchat --namespace rocketchat
