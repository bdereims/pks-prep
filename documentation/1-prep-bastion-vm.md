***Prepare the Bastion VM***

Install your favorite Linux distro as bastion VM. My choice is any Ubuntu LTS.
So, all commands are for this debian derivative distro altought is easy to translate.

Update distro:
$ apt update
$ apt upgrade

Dedicate a directory for the repo and binaries:
$ mkdir -p /data/BITS
$ cd /data

Clone this repo:
$ git clone https://github.com/bdereims/pks-prep
