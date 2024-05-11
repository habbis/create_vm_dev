#!/bin/bash

hostname="dev2"
domain="local.net"
template="deb12-cloud-image.qcow2"
os="debian12"
network="virbr0"
storage="/var/lib/libvirt/images"
ip="192.168.124.3"
netmask="255.255.255.0"
gateway="192.168.124.1"
nameserver1="1.1.1.1"
nameserver2="8.8.8.8"

wget -O user-data https://raw.githubusercontent.com/habbis/cloud-init/master/linux/debian/user-data
wget -O network-config https://raw.githubusercontent.com/habbis/cloud-init/master/linux/debian/network-config
wget -O meta-data https://raw.githubusercontent.com/habbis/cloud-init/master/linux/debian/meta-data

wget -O
sed -i "s|temp|${hostname}.${domain}|g" user-data
sed -i "s|tip|${ip}|g"           user-data
sed -i "s|tempip|${ip}|g"           network-config
sed -i "s|tempmask|${netmask}|g"    network-config
sed -i "s|tempgate|${gateway}|g"    network-config
sed -i "s|10.17.2.2|${nameserver1}|g"    network-config
sed -i "s|10.17.2.3|${nameserver2}|g"    network-config

if [ -e ${hostname}_cloud_init.iso ]; then
   rm -f ${hostname}_cloud_init.iso
  genisoimage -output ${hostname}_cloud_init.iso -V cidata -r -J meta-data user-data network-config
else
  genisoimage -output ${hostname}_cloud_init.iso -V cidata -r -J meta-data user-data network-config
fi

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
