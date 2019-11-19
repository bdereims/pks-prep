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

	echo "Retrieving cluster ${CLUSTER_NAME}..."
	CLUSTER_IP=$(pks cluster ${CLUSTER_NAME} | grep "IP(s)" | sed 's/^.*:  //')
	printf "${CLUSTER_IP}\t${CLUSTER_NAME} ${CLUSTER_NAME}.${DOMAIN}\n" | sudo tee -a /etc/hosts

	echo "Creating user  ${USER_NAME}..."
	sudo useradd -m -p $(openssl passwd -1 "${USER_PASSWORD}") -s /bin/bash ${USER_NAME}
	sudo usermod -G docker ${USER_NAME}

	rm -fr ~/.kube/config
	pks get-credentials ${CLUSTER_NAME}
	sudo mkdir -p /home/${USER_NAME}/.kube
	sudo cp /home/vmware/.kube/config /home/${USER_NAME}/.kube/.	
	sudo chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}
	sudo -u ${USER_NAME} kubectl --kubeconfig=/home/${USER_NAME}/.kube/config config use-context ${CLUSTER_NAME}
	sudo -u ${USER_NAME} kubectl --kubeconfig=/home/${USER_NAME}/.kube/config apply -f /home/vsphere_storage_class.yaml
done
