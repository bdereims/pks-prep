#!/bin/bash
#bdereims@vmware.com

. ./env

upload_opsmanager() {

	HOSTNAME=$( echo ${OVA_OPSMANAGER_NAME} | tr '[:upper:]' '[:lower:]' )

	export MYSCRIPT=/tmp/$$

	cat << EOF > ${MYSCRIPT}
ovftool --acceptAllEulas --skipManifestCheck --X:injectOvfEnv --allowExtraConfig \
--prop:admin_password=${PASSWORD} \
--prop:custom_hostname=${HOSTNAME} \
--prop:ip0=${OVA_OPSMANAGER_IP} \
--prop:netmask0=${NETMASK} \
--prop:gateway=${GATEWAY} \
--prop:DNS=${DNS} \
--prop:ntp_servers=${NTP} \
--powerOn \
--noSSLVerify \
-ds=${VCENTER_DATASTORE} -n=${OVA_OPSMANAGER_NAME} --network='${VCENTER_PORTGROUP}' \
${OVA_OPSMANAGER} \
vi://${VCENTER_USERNAME}:'${VCENTER_PASSWORD}'@${VCENTER_TARGET}
EOF

	sh ${MYSCRIPT}
	rm ${MYSCRIPT}
}

###################

upload_vrli() {

	HOSTNAME=$( echo ${OVA_VRLI_NAME} | tr '[:upper:]' '[:lower:]' )

        export MYSCRIPT=/tmp/$$

	cat << EOF > ${MYSCRIPT}
ovftool --acceptAllEulas --X:injectOvfEnv --allowExtraConfig \
--prop:vami.DNS.VMware_vCenter_Log_Insight=${DNS} \
--prop:vami.domain.VMware_vCenter_Log_Insight=${DOMAIN} \
--prop:vami.gateway.VMware_vCenter_Log_Insight=${GATEWAY} \
--prop:vami.hostname.VMware_vCenter_Log_Insight=${HOSTNAME} \
--prop:vami.ip0.VMware_vCenter_Log_Insight=${OVA_VRLI_IP} \
--prop:vami.netmask0.VMware_vCenter_Log_Insight=${NETMASK} \
--prop:vami.searchpath.VMware_vCenter_Log_Insight=${DOMAIN} \
--prop:vm.rootpw=${PASSWORD} \
--powerOn \
--noSSLVerify \
-ds=${VCENTER_DATASTORE} -n=${OVA_VRLI_NAME} "--network=${VCENTER_PORTGROUP}" \
${OVA_VRLI} \
vi://${VCENTER_USERNAME}:'${VCENTER_PASSWORD}'@${VCENTER_TARGET}
EOF

        sh ${MYSCRIPT}
        rm ${MYSCRIPT}
}

###################

upload_vrops() {

	HOSTNAME=$( echo ${OVA_VROPS_NAME} | tr '[:upper:]' '[:lower:]' )

        export MYSCRIPT=/tmp/$$

	cat << EOF > ${MYSCRIPT}
ovftool --acceptAllEulas --X:injectOvfEnv --allowExtraConfig \
"--prop:vamitimezone=Europe/Paris" \
--prop:vami.DNS.vRealize_Operations_Manager_Appliance=${DNS} \
--prop:vami.gateway.vRealize_Operations_Manager_Appliance=${GATEWAY} \
--prop:vami.ip0.vRealize_Operations_Manager_Appliance=${OVA_VROPS_IP} \
--prop:vami.netmask0.vRealize_Operations_Manager_Appliance=${NETMASK} \
--powerOn \
--noSSLVerify \
-ds=${VCENTER_DATASTORE} -n=${OVA_VROPS_NAME} "--network=${VCENTER_PORTGROUP}" \
${OVA_VROPS} \
vi://${VCENTER_USERNAME}:'${VCENTER_PASSWORD}'@${VCENTER_TARGET}
EOF

        sh ${MYSCRIPT}
        rm ${MYSCRIPT}
}

###################

if [ "${OVA_OPSMANAGER_DEPLOY}" == "YES" ]; then
	upload_opsmanager
fi
if [ "${OVA_VRLI_DEPLOY}" == "YES" ]; then
	upload_vrli
fi
if [ "${OVA_VROPS_DEPLOY}" == "YES" ]; then
	upload_vrops
fi
