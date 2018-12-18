#!/bin/sh
#bdereims@vmware.com

KUBEDNS=$( kubectl describe services kube-dns --namespace kube-system | grep "Endpoints" | head -1 | cut -f2 -d':' | sed 's/ //g' ) 
dig -p 53 @${KUBEDNS} kubernetes.default.svc.cluster.local
