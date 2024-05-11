#!/bin/bash

name=$1
new_size=$2

if [ -z $name ]; then
  echo "input name both used for disk and vm"
  exit 1
fi

if [ -z $new_size ]; then
  echo "input new disk size in gigabyte"
  exit 1
fi

virsh shutdown $name.local.net

sleep 10

qemu-img resize /var/lib/libvirt/images/${name}_disk1.qcow2 ${new_size}G

virsh start $name.local.net
