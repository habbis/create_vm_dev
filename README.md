# create vm dev


Create vm using kvm and cloud-init on linux.


### Install kvm.

debian/ubuntu

```
sudo apt -y install qemu-kvm libvirt-daemon  bridge-utils virtinst libvirt-daemon-system virt-manager
```

fedoa/rhel

```
dnf install @virtualization
```

or

```
sudo dnf group install --with-optional virtualization
```
enable libvirt.
```
systemctl enable --now libvirtd
```

Add your user to libvirt group.

```
usermod -aG libvirt youruser
```

### Download cloud image

Get latest debian stable cloud image for x86.
```
wget https://cloud.debian.org/images/cloud/bookworm/daily/latest/debian-12-genericcloud-amd64-daily.qcow2
```
Download checksum.
```
wget https://cloud.debian.org/images/cloud/bookworm/daily/latest/SHA512SUMS
```

Verify checksum.
```
sha512sum -c SHA512SUMS
```
