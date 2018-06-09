#!/bin/bash
#bdereims@vmware.com

### Local vars ####

PASSWORD="VMware1!"
NETMASK="255.255.255.0"
GATEWAY="172.18.5.1"
DNS=${GATEWAY}
NTP=${GATEWAY}
DATASTORE="Datastore"
PORTGROUP="VM Network"
ADMIN="administrator%40cpod-gv.shwrfr.mooo.com"
VC_PASSWORD="VMware1!"
TARGET="vcsa.cpod-gv.shwrfr.mooo.com/cPod-GV/host/Cluster"

###################

upload_opsmanager() {

	NAME=OPSMANAGER
	HOSTNAME="opsmanager"
	OVA=/data/BITS/PKS/pcf-vsphere-2.1-build.214.ova
	IP="172.18.5.11"	

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
	rm ${MYSCRIPT}
}

###################

upload_vrli() {

        NAME=VRLI
        HOSTNAME="vrli"
        OVA=/data/BITS/vREALIZE/VMware-vRealize-Log-Insight-4.5.1-6858700.ova
        IP="172.18.5.9"

        export MYSCRIPT=/tmp/$$

	cat << EOF > ${MYSCRIPT}
ovftool --acceptAllEulas --X:injectOvfEnv --allowExtraConfig \
--prop:vami.DNS.VMware_vCenter_Log_Insight=${DNS} \
--prop:vami.domain.VMware_vCenter_Log_Insight=${DOMAIN} \
--prop:vami.gateway.VMware_vCenter_Log_Insight=${GATEWAY} \
--prop:vami.hostname.VMware_vCenter_Log_Insight=${HOSTNAME} \
--prop:vami.ip0.VMware_vCenter_Log_Insight=${IP} \
--prop:vami.netmask0.VMware_vCenter_Log_Insight=${NETMASK} \
--prop:vami.searchpath.VMware_vCenter_Log_Insight=${DOMAIN} \
--prop:vm.rootpw=${PASSWORD} \
-ds=${DATASTORE} -n=${NAME} "--network=${PORTGROUP}" \
${OVA} \
vi://${ADMIN}:'${VC_PASSWORD}'@${TARGET}
EOF

        sh ${MYSCRIPT}
        rm ${MYSCRIPT}
}

###################

upload_vrops() {

        NAME=VROPS
        HOSTNAME="vrops"
        OVA=/data/BITS/vREALIZE/vRealize-Operations-Manager-Appliance-6.7.0.8183617_OVF10.ova
        IP="172.18.5.10"

        export MYSCRIPT=/tmp/$$

	cat << EOF > ${MYSCRIPT}
ovftool --acceptAllEulas --X:injectOvfEnv --allowExtraConfig \
"--prop:vamitimezone=Europe/Paris" \
--prop:vami.DNS.vRealize_Operations_Manager_Appliance=${DNS} \
--prop:vami.gateway.vRealize_Operations_Manager_Appliance=${GATEWAY} \
--prop:vami.ip0.vRealize_Operations_Manager_Appliance=${IP} \
--prop:vami.netmask0.vRealize_Operations_Manager_Appliance=${NETMASK} \
-ds=${DATASTORE} -n=${NAME} "--network=${PORTGROUP}" \
${OVA} \
vi://${ADMIN}:'${VC_PASSWORD}'@${TARGET}
EOF

        sh ${MYSCRIPT}
        rm ${MYSCRIPT}
}

###################

upload_opsmanager
upload_vrli
upload_vrops
