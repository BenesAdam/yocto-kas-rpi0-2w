#!/bin/bash

ssh-keygen -R 192.168.7.2 2>/dev/null || true

USB_IFACE=$(ip -o link show | grep -oP '^[^:]+: \Kenp[^:]+' | head -1)

if [ -z "$USB_IFACE" ]; then
    echo "No USB ethernet interface found!"
    exit 1
fi

MAC=$(ip link show "$USB_IFACE" | grep -oP 'link/ether \K[0-9a-f:]+')

sudo ip addr replace 192.168.7.1/24 dev "$USB_IFACE"

CURRENT_IP=$(ip addr show "$USB_IFACE" | grep -oP 'inet \K[0-9.]+')

echo "Connected via:"
echo "  Device: $USB_IFACE"
echo "  MAC: $MAC"
echo "  IP: $CURRENT_IP"

ssh root@192.168.7.2
