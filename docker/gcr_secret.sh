SECRETNAME=regsecret
NAMESPACE=elasticsky

kubectl create namespace ${NAMESPACE}

kubectl -n ${NAMESPACE} create secret docker-registry $SECRETNAME \
--docker-server=eu.gcr.io \
--docker-username=_json_key \
--docker-email=user@example.com \
--docker-password="$(cat k8s-gcr-auth-ro.json)"

kubectl -n ${NAMESPACE} patch serviceaccount default \
-p "{\"imagePullSecrets\": [{\"name\": \"$SECRETNAME\"}]}"

#kubectl -n ${NAMESPACE} apply -f hello-web.yaml 
