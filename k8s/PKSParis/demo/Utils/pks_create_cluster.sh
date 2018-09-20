#/bin/sh

pks create-cluster pks-demo --external-hostname pks-demo --plan small --num-nodes 5 

echo "Wait cluster creation and do: pks get-credentials [cluster-name]"
