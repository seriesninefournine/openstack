#!/bin/bash

set -e

useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack
sudo -u stack -i

git clone https://opendev.org/openstack/devstack.git -b stable/xena

sed -i -e 's/$cmd_pip $upgrade/$cmd_pip $upgrade --ignore-installed/g' ./devstack/inc/python 
cd devstack


echo '# Sample ``local.conf`` for user-configurable variables in ``stack.sh``

[[local|localrc]]

ADMIN_PASSWORD=12345678
DATABASE_PASSWORD=stackdb
RABBIT_PASSWORD=stackqueue
SERVICE_PASSWORD=$ADMIN_PASSWORD

IP_VERSION=4
SERVICE_IP_VERSION=4
HOST_IP=192.168.10.100

LOGFILE=$DEST/logs/stack.sh.log

LOG_COLOR=False' > local.conf

./stack.sh
