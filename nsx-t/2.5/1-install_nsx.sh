#!/bin/bash -e
#bdereims@vmware.com

. ../../env

install_nsx_manager() {
ovftool \
--deploymentOption="small" \
--sourceType=OVA \
--name="${NSX_MANAGER_NAME}-1" \
--X:injectOvfEnv --X:logFile=ovftool.log --allowExtraConfig \
--acceptAllEulas --noSSLVerify --diskMode=thin --powerOn \
--prop:nsx_role="NSX Manager" \
--prop:nsx_ip_0=${NSX_MANAGER_IP} \
--prop:nsx_netmask_0=${NSX_COMMON_NETMASK} \
--prop:nsx_gateway_0=${NSX_COMMON_GATEWAY} \
--prop:nsx_dns1_0=${NSX_COMMON_DNS} \
--prop:nsx_domain_0=${NSX_COMMON_DOMAIN} \
--prop:nsx_ntp_0=${NSX_COMMON_NTP} \
--prop:nsx_isSSHEnabled=True \
--prop:nsx_allowSSHRootLogin=True \
--prop:nsx_passwd_0="${NSX_COMMON_PASSWORD}" \
--prop:nsx_cli_passwd_0="${NSX_COMMON_PASSWORD}" \
--prop:nsx_hostname=nsx-1 \
--datastore="${NSX_HOST_MGMT_DATASTORE}" \
--network="${NSX_HOST_COMMON_NETWORK0}" \
${NSX_MANAGER_OVA_FILE} \
vi://${VCENTER_USERNAME}:${VCENTER_PASSWORD}@${VCENTER_IP}/${NSX_HOST_COMMON_DATACENTER}/host/${NSX_HOST_MGMT_CLUSTER}
}

install_nsx_edge() {
ovftool \
--name="${NSX_EDGE_NAME}-1" \
--deploymentOption=large \
--X:injectOvfEnv --X:logFile=ovftool.log --allowExtraConfig \
--net:"Network 0=${VCENTER_PORTGROUP}" \
--net:"Network 1=${VCENTER_PORTGROUP}" \
--net:"Network 2=${VCENTER_PORTGROUP}" \
--net:"Network 3=${VCENTER_PORTGROUP}" \
--acceptAllEulas --noSSLVerify --diskMode=thin --powerOn \
--prop:nsx_ip_0=${NSX_EDGE_IP} \
--prop:nsx_netmask_0=${NSX_COMMON_NETMASK} \
--prop:nsx_gateway_0=${NSX_COMMON_GATEWAY} \
--prop:nsx_dns1_0=${NSX_COMMON_DNS} \
--prop:nsx_domain_0=${NSX_COMMON_DOMAIN} \
--prop:nsx_ntp_0=${NSX_COMMON_NTP} \
--prop:nsx_isSSHEnabled=True \
--prop:nsx_allowSSHRootLogin=True \
--prop:nsx_passwd_0="${NSX_COMMON_PASSWORD}" \
--prop:nsx_cli_passwd_0="${NSX_COMMON_PASSWORD}" \
--prop:nsx_hostname=nsx-edge-1 \
--datastore="${NSX_HOST_MGMT_DATASTORE}" \
--diskMode=thin \
${NSX_EDGE_OVA_FILE} \
vi://${VCENTER_USERNAME}:${VCENTER_PASSWORD}@${VCENTER_IP}/${NSX_HOST_COMMON_DATACENTER}/host/${NSX_HOST_MGMT_CLUSTER}
}

install_nsx_manager
install_nsx_edge

printf "\n\n###\n### Wait until complet startup of Manager & Edge...\n###\n"
