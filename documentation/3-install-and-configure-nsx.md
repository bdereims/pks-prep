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


[vcsa-nsx]: img/vcsa-nsx.png "VCSA NSX"
[configure-nsx]: img/configure-nsx.png "VCSA NSX"
