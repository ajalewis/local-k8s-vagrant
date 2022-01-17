#!/bin/bash
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-bionic.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.56.2  master-ashworth
192.168.56.3  node01-ashworth
192.168.56.4  node02-ashworth
EOF

# Update TZ
sudo timedatectl set-timezone 'Australia/Brisbane'

# Remove unneccessary MOTD addons
sudo chmod -x /etc/update-motd.d/00-header /etc/update-motd.d/10-help-text

