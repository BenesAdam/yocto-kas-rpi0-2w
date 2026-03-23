#!/bin/bash

# Uncomment on "DOINT SOMETHING NASTY" warning
ssh-keygen -R 192.168.7.2

# Set IP to enp10s0u3
# Get by "ip link show"
sudo ip addr add 192.168.7.1/24 dev enp10s0u3

# Connect as root
ssh -v root@192.168.7.2
