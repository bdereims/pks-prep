#!/bin/bash
#bdereims@vmware.com

HARBOR=harbor.pks-reg.goodvibes/library

for IMAGE in $(docker images | awk '{print $1":"$2}' | tail +2)
do
	echo $IMAGE
	TARGET=$(echo $IMAGE | sed -e "s#^.*/##")
	TARGET=$HARBOR/$TARGET
	docker tag $IMAGE $TARGET
	docker push $TARGET
done
