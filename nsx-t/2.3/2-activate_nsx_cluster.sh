#!/bin/bash -e

#source ./install_nsx.env

. ../../env

function configure_nsx_cluster() {

  local manager_ip=$NSX_MANAGER_IP
  local manager_password=${NSX_MANAGER_PASSWORD:=$NSX_COMMON_PASSWORD}
  local controller_ip=$NSX_CONTROLLER_IP
  local controller_password=${NSX_CONTROLLER_PASSWORD:=$NSX_COMMON_PASSWORD}
  local edge_ip=$NSX_EDGE_IP
  local edge_password=${NSX_EDGE_PASSWORD:=$NSX_COMMON_PASSWORD}

#  sed -i -e "/^$manager_ip/ d" ~/.ssh/known_hosts || true
#  sed -i -e "/^$controller_ip/ d" ~/.ssh/known_hosts || true
#  sed -i -e "/^$edge_ip/ d" ~/.ssh/known_hosts || true

  echo "Get NSX manager thumbprint"
#  eval sshpass -p $manager_password ssh -o StrictHostKeyChecking=no root@$manager_ip "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"set logging-server ${OVA_VRLI_IP} proto udp level info\""
  local manager_thumbprint=`eval sshpass -p $manager_password ssh -o StrictHostKeyChecking=no root@$manager_ip "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"get certificate api thumbprint\""`

I=0
for CTRL_IP in ${NSX_CONTROLLER_IP[@]}; do
  echo "Join NSX controller(s) to management plane"
  echo "---"

#  eval sshpass -p $manager_password ssh -o StrictHostKeyChecking=no root@${CTRL_IP} "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"set logging-server ${OVA_VRLI_IP} proto udp level info\""

  eval sshpass -p $controller_password ssh root@${CTRL_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"join management-plane $manager_ip username admin thumbprint $manager_thumbprint password $manager_password\""
  eval sshpass -p $controller_password ssh root@${CTRL_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"set control-cluster security-model shared-secret secret $controller_password\""
  controller_thumbprint[${I}]=`eval sshpass -p ${controller_password} ssh -o StrictHostKeyChecking=no root@${CTRL_IP} "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"get control-cluster certificate thumbprint\""`

  I=$( expr ${I} + 1 )
done
  
eval sshpass -p $controller_password ssh root@${NSX_CONTROLLER_IP[0]} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"initialize control-cluster\""

I=1
CTRL_SECONDARY=$( echo ${NSX_CONTROLLER_IP[@]} | awk '{ print $2" "$3}' )
if [ "X${NSX_CONTROLLER_IP[1]}X" != "XX" ]; then
	for CTRL_IP in ${CTRL_SECONDARY}; do

  		eval sshpass -p $controller_password ssh root@${NSX_CONTROLLER_IP[0]} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"join management-plane $manager_ip username admin thumbprint $manager_thumbprint password $manager_password\""
  		eval sshpass -p $controller_password ssh root@${NSX_CONTROLLER_IP[0]} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"join control-cluster ${CTRL_IP} thumbprint ${controller_thumbprint[${I}]}\""

  		eval sshpass -p $controller_password ssh root@${CTRL_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"activate control-cluster\""

  		I=$( expr ${I} + 1 )
	done
else
	eval sshpass -p $controller_password ssh root@${NSX_CONTROLLER_IP[0]} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"get control-cluster status\""
fi
	
eval sshpass -p $controller_password ssh root@${NSX_CONTROLLER_IP[0]} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"activate control-cluster\""
	
for EDGE_IP in ${NSX_EDGE_IP[@]}; do
  echo "---"
  echo "Join NSX edge(s) to management plane"

#  eval sshpass -p $manager_password ssh -o StrictHostKeyChecking=no root@${EDGE_IP} "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"set logging-server ${OVA_VRLI_IP} proto udp level info\""

  eval sshpass -p $edge_password ssh root@${EDGE_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"join management-plane $manager_ip username admin thumbprint $manager_thumbprint password $manager_password\""
done

eval sshpass -p $controller_password ssh root@${NSX_CONTROLLER_IP[0]} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"get control-cluster status\""
}


######################################################
#						     #
#   Main Script					     #
#						     #
######################################################


echo ""
echo "Activate NSX cluster"
echo ""

#rm ~/.ssh/known_hosts  
configure_nsx_cluster


echo ""
echo "OPERATION COMPLETED: Activate NSX cluster"
echo ""
echo "Verifiy the configuration in NSX GUI, strongly suggest to wait few minutes before execute next step"
echo ""
