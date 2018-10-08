#!/bin/bash -e

#source ./install_nsx.env

source ../env

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


for CTRL_IP in ${NSX_CONTROLLER_IP[@]}; do
  echo "Join NSX controller to management plane"
#  eval sshpass -p $manager_password ssh -o StrictHostKeyChecking=no root@${CTRL_IP} "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"set logging-server ${OVA_VRLI_IP} proto udp level info\""
  eval sshpass -p $controller_password ssh root@${CTRL_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"join management-plane $manager_ip username admin thumbprint $manager_thumbprint password $manager_password\""
  eval sshpass -p $controller_password ssh root@${CTRL_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"set control-cluster security-model shared-secret secret $controller_password\""
  eval sshpass -p $controller_password ssh root@${CTRL_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"initialize control-cluster\""
done

for EDGE_IP in ${NSX_EDGE_IP[@]}; do
  echo "Join NSX edge(s) to management plane"
#  eval sshpass -p $manager_password ssh -o StrictHostKeyChecking=no root@${EDGE_IP} "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"set logging-server ${OVA_VRLI_IP} proto udp level info\""
  eval sshpass -p $edge_password ssh root@${EDGE_IP} -o StrictHostKeyChecking=no "/opt/vmware/nsx-cli/bin/scripts/nsxcli -c \"join management-plane $manager_ip username admin thumbprint $manager_thumbprint password $manager_password\""
done
}


######################################################
#						     #
#   Main Script					     #
#						     #
######################################################


echo ""
echo "Activate NSX cluster"
echo ""

rm ~/.ssh/known_hosts  
configure_nsx_cluster


echo ""
echo "OPERATION COMPLETED: Activate NSX cluster"
echo ""
