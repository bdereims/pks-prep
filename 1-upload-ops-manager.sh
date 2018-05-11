#!/bin/bash
#bdereims@vmware.com

### Local vars ####

HOSTNAME=${HOSTNAME_OPSMANAGER}
NAME=${NAME_OPSMANAGER}
IP=${IP_OPSMANAGER}
OVA=${OVA_OPSMANAGER}
PASSWORD="VMware1!"
HOSTNAME="opsmanager"
IP="172.18.13.1"
NETMASK="255.255.255.0"
GATEWAY="172.18.13.1"
DNS=${GATEWAY}
NTP=${GATEWAY}
DATASTORE="Datastore"
PORTGROUP="VM Network"
ADMIN="administrator@cpod-goodvibes.shwrfr.mooo.com"
VC_PASSWORD="VMware1!"
TARGET="/cPod-GOODVIBES/host/Cluster"

###################

export MYSCRIPT=/tmp/$$

cat << EOF > ${MYSCRIPT}
ovftool --acceptAllEulas --skipManifestCheck --X:injectOvfEnv --allowExtraConfig \
--prop:admin_password=${PASSWORD} \
--prop:custom_hostname=${HOSTNAME} \
--prop:ip0=${IP} \
--prop:netmask0=${NETMASK} \
--prop:gateway=${GATEWAY} \
--prop:DNS=${DNS} \
--prop:ntp_servers=${NTP} \
-ds=${DATASTORE} -n=${NAME} --network='${PORTGROUP}' \
${OVA} \
vi://${ADMIN}:'${VC_PASSWORD}'@${TARGET}
EOF

sh ${MYSCRIPT}

#rm ${MYSCRIPT}
