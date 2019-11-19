#!/bin/bash
#bdereims@vmware.com

. ../env

pushd .. 
./4-pks_login.sh
popd

for i in $(seq 1 ${STUDENTS}) 
do
	CLUSTER_NAME="cluster-${i}"
	USER_NAME="user-${i}"
	echo "Deleting cluster ${CLUSTER_NAME}..."
	pks delete-cluster ${CLUSTER_NAME} --non-interactive 
	sudo deluser ${USER_NAME} docker
	sudo deluser --remove-home ${USER_NAME}
	sudo sed -i "/${CLUSTER_NAME}/d" /etc/hosts
done
