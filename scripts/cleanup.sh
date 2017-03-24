#!/bin/bash

# Remove Ansible and its dependencies.
yum -C -y remove kernel-firmware ansible libyaml python-babel python-crypto python-crypto2.6 python-httplib2 python-httplib2 python-jinja2-26 python-keyczar python-markupsafe python-paramiko python-pyasn1 python-setuptools python-simplejson sshpass PyYAML

# Delete old kernels
package-cleanup -C -y --oldkernels --count=1

# Clean yum cache
echo "Cleaning up extra files"
rm -rf /var/cache/yum/*
rm -rf /usr/share/man/*
rm -rf /usr/share/info/*
rm -rf /usr/share/doc/*
rm -rf /usr/share/backgrounds/*

# Zero out the rest of the free space using dd, then delete the written file.
echo "Reclaming free space on disk"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync

