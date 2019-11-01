#!/bin/bash
set -eux

cat >>/etc/hosts.deny <<EOF
sshd: ALL
EOF

cat >>/etc/hosts.allow <<EOF
sshd: localhost 129.241.0.0/16 10.0.2.2
EOF

service ssh restart

apt-get install strongswan -y

sysctl net.ipv4.ip_forward=1

ipsec restart
ipsec status
systemctl enable strongswan

# For checking policies and states of the IPsec Tunnel
ip xfrm state
ip xfrm policy
