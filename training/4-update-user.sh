#!/bin/bash
#bdereims@vmware.com

. ../env

USER_PASSWORD="VMware1!"

for i in $(seq 1 ${STUDENTS}) 
do
	USER_NAME="user-${i}"
	echo "Updating user ${USER_NAME}..."
	sudo rm -fr /home/${USER_NAME}/.bashrc
	sudo ln -s /home/.bashrc /home/${USER_NAME}/.bashrc
done
