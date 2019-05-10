# Deploy-NSX-T using SHELL: automatically deploy and configure NSX-T
This project contains scripts to Install and Configure NSX-T (any version of NSX-T).

The scripts are based on Linux Shell and use stadard tools like OVFtool, sshpass, jq and curl.

Scripts are:
* 1-install_nsx.sh
* 2-activate_nsx_cluster.sh
* 3-configure_nsx.sh

A final script all-install_activate_configure_nsx.sh uses the aboves scripts in sequence.
You have the choice to either launch each script one after the other (advantage is to check all steps) - or - launch the all script that will automate all sequences.


#### 1-install_nsx.sh
Creates the following NSX-T components:
* 1 NSX Manager (NSX Manager will be instantiated in the MGMT cluster)
* 1 NSX Controller (NSX Controller will be instantiated in the MGMT cluster)
* 1 NSX Edge ((NSX Edge will be instantiated in the COMPUTE cluster)

#### 2-activate_nsx_cluster.sh
Form NSX-T cluster:
NSX Controller will be registered to NSX Manager
NSX Edge will be registered to NSX Manager

#### 3-configure_nsx.sh
Create following NSX-T objects:
* Creating VLAN transport zone
* Creating OVERLAY transport zone
* Creating uplink profile
* Creating IP address pool
* Configuring Edge transport node
* Creating Edge cluster
* Creating T0 router
* Creating logical switch
* Creating logical port
* Creating router port
* Adding static route
* Creating T1 router
* Creating router port in T0 for DHCP router
* Creating router port in DHCP router and link it to T0 router port
* Creating logical switch to connect to dhcp server
* Creating logical port to connect to dhcp server
* Creating router port to connect to dhcp server
* Configuring router advertisement configuration


## System requirements
To run these scripts, you need:
* 1 VM running Linux (Ubuntu tested here) - the scripts can be running on your MAC laptop as well
* OVFTool installed in the VM
* sshpass installed in the VM
* jq installed in the VM

## Lab requirements
NSX-T will be deployed in the lab with the following config:
* 1 MGMT cluster (will host NSX Manager and NSX Controller)
* 1 COMPUTE cluster (will host NSX Edge)

## OVA bits
It's up to the user to download all NSX OVA bits.
location of NSX Manager, NSX Controller and NSX Edge OVA files will then be provided to env var file install_nsx.env. 


## Procedure
### step 1: install NSX


On the LINUX VM:

Modify file named 'install_nsx.env' with your environment attributes:
```
# Location of OVA files
export NSX_MANAGER_OVA_FILE=/DATA/BINARIES/NSX-T-2-0-0/nsx-unified-appliance-2.0.0.0.0.6522097.ova
export NSX_CONTROLLER_OVA_FILE=/DATA/BINARIES/NSX-T-2-0-0/nsx-controller-2.0.0.0.0.6522091.ova
export NSX_EDGE_OVA_FILE=/DATA/BINARIES/NSX-T-2-0-0/nsx-edge-2.0.0.0.0.6522113.ova

# VM names on vCenter
export NSX_MANAGER_NAME=NSX-T_manager
export NSX_CONTROLLER_NAME=NSX-T_controller
export NSX_EDGE_NAME=NSX-T_edge

# vCenter attributes
export VCENTER_IP=10.40.206.61
export VCENTER_USERNAME="administrator@vsphere.local"
export VCENTER_PASSWORD="VMware1!"

# vCenter DC name
export NSX_HOST_COMMON_DATACENTER=Datacenter

# Compute Cluster (for NSX Edge VM)
export NSX_HOST_COMPUTE_CLUSTER=COMP-Cluster-1
export NSX_HOST_COMPUTE_DATASTORE=NFS-LAB-DATASTORE

# Management Cluster (for NSX Manager and NSX Controller)
export NSX_HOST_MGMT_CLUSTER=MGMT-Cluster
export NSX_HOST_MGMT_DATASTORE=NFS-LAB-DATASTORE

# Network0: MGMT port-group
# Network1: Edge VTEP port-group
# Network2: Edge Uplink port-group
export NSX_HOST_COMMON_NETWORK0=CNA-VM
export NSX_HOST_COMMON_NETWORK1=NSX-VTEP-PG
export NSX_HOST_COMMON_NETWORK2=CNA-INFRA
export NSX_HOST_COMMON_NETWORK3=CNA-INFRA

# NSX Manager, Controller, Edge Network Attributes
export NSX_MANAGER_IP=10.40.207.33
export NSX_CONTROLLER_IP=10.40.207.34
export NSX_EDGE_IP=10.40.207.35
export NSX_COMMON_PASSWORD="VMware1!"
export NSX_COMMON_DOMAIN="nsx.vmware.com"
export NSX_COMMON_NETMASK=255.255.255.0
export NSX_COMMON_GATEWAY=10.40.207.253
export NSX_COMMON_DNS=10.20.20.1
export NSX_COMMON_NTP=10.113.60.176
```

Source it:
```
source install_nsx.env
```

Then run the first script:
```
./1-install_nsx.sh
```


### Step 2: enable NSX cluster

Make sure NSX Manager, NSX Controller and NSX Edge are up and running before moving forward.

Run the second script:
```
./2-enable_nsx_cluster.sh
```


### Step 3: configure NSX

Modify file named 'configure_nsx.env' with your environment attributes:
```
export NETWORK_TUNNEL_IP_POOL_CIDR="192.168.150.0/24"
export NETWORK_TUNNEL_IP_POOL_ALLOCATION_START="192.168.150.200"
export NETWORK_TUNNEL_IP_POOL_ALLOCATION_END="192.168.150.250"
export NETWORK_T0_SUBNET_IP_ADDRESS="10.40.206.20"
export NETWORK_T0_SUBNET_PREFIX_LENGTH=25
export NETWORK_T0_GATEWAY="10.40.206.125"
export NETWORK_HOST_UPLINK_PNIC='vmnic1'
```

Source it:
```
source configure_nsx.env
```

Then run the third script:
```
3-configure_nsx.sh
```

#

