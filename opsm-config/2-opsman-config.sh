#!/bin/bash
#bdereims@vmware.com

. ../env

. ./opsman-connect.sh

OUTCOMES="../nsx-t/outcomes.lst"

CIDR="1.1.1"

IP_BLOCK_ID=$( cat ${OUTCOMES} | head -1 | sed "s/^.*: //" )
NODES_IP_BLOCK_ID=$( cat ${OUTCOMES} | head -2 | tail -1 | sed "s/^.*: //" )
T0_ROUTER_ID=$( cat ${OUTCOMES} | head -3 | tail -1 | sed "s/^.*: //" )
FLOATING_IP_POOL_ID=$( cat ${OUTCOMES} | head -4 | tail -1 | sed "s/^.*: //" )

NSX_CRT=$( awk '{print}' ORS='\\\\r\\\\n' ../nsx-t/nsx.crt )
PKS_NSX_T_SUPERUSER_CRT=$( awk '{print}' ORS='\\\\r\\\\n' ../nsx-t/pks-nsx-t-superuser.crt )
PKS_NSX_T_SUPERUSER_KEY=$( awk '{print}' ORS='\\\\r\\\\n' ../nsx-t/pks-nsx-t-superuser.key )

cat ./installsettings.json-template | sed -e "s/###VCENTER###/${VCENTER}/" \
-e "s/###CLUSTER###/${VCENTER_CLUSTER}/" \
-e "s/###DATACENTER###/${VCENTER_DATACENTER}/" \
-e "s/###DATASTORE###/${VCENTER_DATASTORE}/" \
-e "s/###DOMAIN###/${DOMAIN}/" \
-e "s/###PASSWORD###/${PASSWORD}/" \
-e "s/###CIDR###/${CIDR}/g" \
-e "s/###DNS###/${DNS}/" \
-e "s/###GATEWAY###/${GATEWAY}/" \
-e "s/###NTP###/${NTP}/" \
-e "s/###ADMIN###/${ADMIN}/" \
-e "s/###T0_ROUTER_ID###/${T0_ROUTER_ID}/" \
-e "s/###IP_BLOCK_ID###/${IP_BLOCK_ID}/" \
-e "s/###FLOATING_IP_POOL_ID###/${FLOATING_IP_POOL_ID}/" \
-e "s/###NODES_IP_BLOCK_ID###/${NODES_IP_BLOCK_ID}/" \
> installsettings.json

sed -i \
-e "s@###NSX_CRT###@${NSX_CRT}@" \
-e "s@###PKS_NSX_T_SUPERUSER_CRT###@${PKS_NSX_T_SUPERUSER_CRT}@" \
-e "s@###PKS_NSX_T_SUPERUSER_KEY###@${PKS_NSX_T_SUPERUSER_KEY}@" \
installsettings.json

curl -s -k -H 'Accept: application/json;charset=utf-8' \
	-H "Content-Type: multipart/form-data" -H "Authorization: Bearer ${TOKEN}" \
	https://${OPSMANAGER}/api/installation_settings \
	-X POST -F "installation[file]=@installsettings.json"
