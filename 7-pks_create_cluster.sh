#/bin/sh

. ./env

pks create-network-profile lb-medium.json
pks create-cluster ${CLUSTER_NAME} --external-hostname ${CLUSTER_NAME} --plan default --num-nodes 3 --network-profile lb-profile-medium

echo "Wait cluster creation and do: pks get-credentials [cluster-name]"
