# Prepare the Bastion VM

Install your favorite Linux distro as bastion VM. My choice is any Ubuntu LTS.
So, all commands are for this debian derivative distro altought is easy to translate.

Update distro:\
`$ apt update`\
`$ apt upgrade`

Dedicate a directory for the repo and binaries:\
`$ mkdir -p /data/BITS`\
`$ cd /datai`

Clone this repo:\
`$ git clone https://github.com/bdereims/pks-prep`

Update VM to execute scripts:\
`$ cd pks-prep`\
`$ ./0-update.sh`

Download all binaries:
- PKS product + Pivotal Opsmanager from pivotal.io
- NSX-T Manager, Controler and Edge OVAs

You should obtain something like this:\
![alt text][bastion-vm]

[bastion-vm]: img/bastion-vm.png "Bastion VM"
