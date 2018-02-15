#/bin/sh

kubectl create -f vsphere_storage_class.yaml
kubectl patch storageclass thin-disk -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
