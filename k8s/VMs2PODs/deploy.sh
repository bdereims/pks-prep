#!/bin/bash -e
#bdereims@vmware.com

. ./env

EXIST=$(kubectl get namespaces -o json | jq -r ".items[] | select(.metadata.name==\"${NAMESPACE}\") | .metadata.name")
if [ "X${EXIST}" != "X" ]; then
	kubectl delete namespace ${NAMESPACE}
fi

kubectl create namespace ${NAMESPACE}
./kubectl_apply.sh back-end.yaml
./kubectl_apply.sh front-end.yaml

exit 0
