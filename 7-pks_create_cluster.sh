#/bin/sh

. ./env

pks create-cluster ${CLUSTER_NAME} --external-hostname ${CLUSTER_NAME} --plan small --num-nodes 3 --network-profile lb-profile-medium

echo "Wait cluster creation and do: pks get-credentials [cluster-name]"
