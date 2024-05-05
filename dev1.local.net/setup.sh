#!/bin/bash

hostname="dev1"
domain="local.net"
ip="192.168.1.2"
netmask="255.255.255.0"
gateway="192.168.1.1"

wget -O user-data https://raw.githubusercontent.com/habbis/cloud-init/master/linux/debian/user-data
wget -O network-config https://raw.githubusercontent.com/habbis/cloud-init/master/linux/debian/network-config
wget -O meta-data https://raw.githubusercontent.com/habbis/cloud-init/master/linux/debian/meta-dat
wget -O

wget -O
sed -i "s|temp|${hostname}.${domain}|g" user-data
sed -i "s|tip|${ip}|g"           user-data
sed -i "s|tempip|${ip}|g"           network-config
sed -i "s|tempmask|${netmask}|g"    network-config
sed -i "s|tempgate|${gateway}|g"    network-config

if [ -e ${hostname}_cloud_init.iso ]; then
   rm -f ${hostname}_cloud_init.iso
  genisoimage -output ${hostname}_cloud_init.iso -V cidata -r -J meta-data user-data network-config
else
  genisoimage -output ${hostname}_cloud_init.iso -V cidata -r -J meta-data user-data network-config
fi
