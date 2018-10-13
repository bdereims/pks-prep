#!/bin/bash

# get download env
source define_download_version_env


# test env variables
if [ $VMWUSER = '<username>' ]
then
    echo "Update VMWUSER value in set_env before running it"
    exit 1
fi

if [ $VMWPASS = '<password>' ]
then
    echo "Update VMWPASS value in set_env before running it"
    exit 1
fi

# OVFTOOL
vmw-cli index $OVFTOOLPG
export ovfFileName=`vmw-cli json productGroup:$OVFTOOLPG,fileName:lin.X86 | jq -r '.fileName'`
vmw-cli get $ovfFileName
mv $ovfFileName $BITSDIR$VMWFOLDER

# NSX-T
vmw-cli index $NSXTPG
# get manager
export nsxMgrFileName=`vmw-cli json productGroup:$NSXTPG,fileType:ova,fileName:unified | jq -r '.fileName'`
vmw-cli get $nsxMgrFileName
mv $nsxMgrFileName $BITSDIR$NSXFOLDER

#get controller
export nsxCtrlFileName=`vmw-cli json productGroup:$NSXTPG,fileType:ova,fileName:controller | jq -r '.fileName'`
vmw-cli get $nsxCtrlFileName
mv $nsxCtrlFileName $BITSDIR$NSXFOLDER

#get edge
export nsxEdgeFileName=`vmw-cli json productGroup:$NSXTPG,fileType:ova,fileName:edge | jq -r '.fileName'`
vmw-cli get $nsxEdgeFileName
mv $nsxEdgeFileName $BITSDIR$NSXFOLDER
