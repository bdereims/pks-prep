#!/bin/bash
#bdereims@vmware.com

. ../env

USER_PASSWORD="VMware1!"

pushd .. 
./4-pks_login.sh
popd

for i in $(seq 1 ${STUDENTS}) 
do
	CLUSTER_NAME="cluster-${i}"
	USER_NAME="user-${i}"
	echo "Creating cluster ${CLUSTER_NAME}..."
	pks create-cluster ${CLUSTER_NAME} --external-hostname ${CLUSTER_NAME}.${DOMAIN} --plan ${STUDENTS_PLAN} --num-nodes ${STUDENTS_NUM_WORKERS} --network-profile ${STUDENTS_NETPROFILE} --wait
done
