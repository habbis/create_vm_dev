#!/bin/bash

hostname="dev1"
domain="local.net"
template="deb12-cloud-image.qcow2"
os="debian12"
network="vrbr1"
storage="/mnt/ssd-storage"

cp -r ${storage}/${template} ${storage}/${hostname}_disk1.qcow2
cp -r ${hostname}_cloud_init.iso  ${storage}/

virt-install --name=${hostname}.${domain} \
       	--ram=4048 \
	--vcpus=4 \
	--import --disk path=${storage}/${hostname}_disk1.qcow2,format=qcow2 \
	--disk path=${storage}/${hostname}_cloud_init.iso,device=cdrom \
	--os-variant=${os} \
	--network bridge=${network} \
	--controller type=usb,model=none \
	--sound none \
	--graphics vnc \
	--autostart \
	--noautoconsole
