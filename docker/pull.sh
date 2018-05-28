#!/bin/bash
#bdereims@vmware.com

for IMAGE in $(cat images)
do
	docker pull $IMAGE
done
