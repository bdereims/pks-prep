#source ./install_nsx.env
source ../env
./1-install_nsx.sh
sleep 180
./2-activate_nsx_cluster.sh

source ./configure_nsx.env
./3-configure_nsx.sh
