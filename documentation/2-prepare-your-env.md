***Prepare your Environnement***

In order to automate installation, you need to maintain a 'env' file describing your installation.

Copy example file:\
`$ cp env-example env`

Edit this file with your favorite editor and update variables accordingly your vSphere installation.
There are some comments and variable names are pretty obvious.

Check some points before to start deployment:\
- NSX Edge need to land on ESXi with 8vCPUs and 16Gb of memory
- Second vNIC of Edge is for TEP connectivity with ESXi, MTU of 1600b is needed for overlay, check the PortGroup/VSS
- Don't forget to activate DRS for the tagerted vSphere Cluster 
