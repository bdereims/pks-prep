#/bin/sh

. ./env

pks create-network-profile lb-medium.json 
pks create-cluster ${CLUSTER_NAME} --external-hostname ${CLUSTER_NAME}.${DOMAIN} --plan default --num-nodes 5 --network-profile lb-profile-medium

echo "Wait cluster creation and do: pks get-credentials [cluster-name]"
