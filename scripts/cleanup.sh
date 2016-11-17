#!/bin/bash

# Remove Ansible and its dependencies.
yum -C -y remove ansible python-crypto python-paramiko python-markupsafe python-httplib2 sshpass python-setuptools python-crypto2 python-simplejson python-pyasn1 python-keyczar libyaml PyYAML python-six python-babel python-jinja2

# Delete old kernels
package-cleanup -C -y --oldkernels --count=1

# Clean yum cache
rm -rf /var/cache/yum/*

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync

