# Install and Configure NSX-T

As a first step, we need to deploy NSX-T automatically based on the 'env' file.

Let's do that:\
`$ cd nsx-t`\
`$ ./1-install_nsx.sh`

It's deploying all NSX VMs for you. I strongly suggest to set Cluster anti-infinity rules to separate NSX Controllers/Edges on different Hosts.

Wait few minutes, VMs are booting it takes time.

You should obtain something like that:\
![alt text][vcsa-nsx]

Activate Controller(s) and Edge(s) against Manager:\
`$ ./2-activate_nsx_cluster.sh`

Configure and create virtual network items in NSX for PKS, you will see created item list:\
`$ ./3-configure_nsx.sh`

The result:\
![alt text][configure-nsx]

Create and upload NSX Service Account and Certificate:\
`$ ./4-nsx-cert.sh`

Check out precious files used later during OpsManager setup:
- nsx.crt
- pks-nsx-t-superuser.crt
- pks-nsx-t-superuser.key

Don't forget to configure vSphere Cluster in NSX-T Manager in order to deploy VIB and set the PNIC:
![alt text][nsx-esx-tep]

Verify that Edges and ESXs are now transport nodes:\
![alt text][nsx-transport-nodes]

Now, NSX-T is almost ready for PKS! You have to adjust depenping your context.

[vcsa-nsx]: img/vcsa-nsx.png "VCSA NSX"
[configure-nsx]: img/configure-nsx.png "VCSA NSX"
[nsx-esx-tep]: img/nsx-esx-tep.png "ESX TEP Network"
[nsx-transport-nodes]: img/nsx-transport-nodes.png "Transport Nodes"
