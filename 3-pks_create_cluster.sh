#/bin/sh

. ./env

pks create-cluster ${CLUSTER_NAME} --plan small --num-nodes 3
