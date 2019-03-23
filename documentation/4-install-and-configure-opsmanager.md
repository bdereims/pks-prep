# Install and Configure Opsmanager 

Second step is to deploy Opsmanager OVA and then configure your deployment.

Let's do that:\
`$ ./1-upload_ova.sh`

Open a web browser with Opsmanager URL and setup authentification.

Upload PKS and Harbor Tiles in Opsmanager:\
`$ ./2-upload_product.sh`

In following steps, only tricky part is descrived.

Within Opsmanager, setup the Bosh Director for vSphere Tile with:
- vCenter Config: NSX-T, copy/paste content of `nsx.crt` fron nsx-t directory
- Director Config: select `Enable VM Resurrector Plugin` and `Enable Post Deploy Scripts` and `Recreate All VMs`
- Security: copy/paste CA Cert from `admin -> Settings -> Advanced -> Download Root CA Cert`

In Pivotal Container Service Tile:

Networking Configurations: 
- under `NSX Manager Super User Principal Identity Certificate` copy/paste `pks-nsx-t-superuser.crt` and `pks-nsx-t-superuser.key` from nsx-t directory
- check box for `Disable SSL certificate verification` because we're using self-signed certificate
- in `NSX Manager CA Cert` copy/past `nsx.crt` from the same directory
- retrieve `Pods IP Block ID`, `Nodes IP Block ID`, `T0 Router ID` and `Floating IP Pool ID` from NSX Manager

Errands:
- put `NSX-T Validation errand` on `On`

Harbor Tile is pretty obvious without trap.

You could "Apply Changes" in order to deploy all that stuffs.

[nsx-transport-nodes]: img/nsx-transport-nodes.png "Transport Nodes"
