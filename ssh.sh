#!/bin/bash

HOST="192.168.7.2"
HOST_IP="192.168.7.1"
HOST_IP_CIDR="${HOST_IP}/24"
DEVICE_WAIT_TIMEOUT_SECONDS=10
PING_TIMEOUT_SECONDS=15

export TERM=xterm-256color

# Check if USB device is connected
device=$(./find-device.sh 2>/dev/null || true)
if [[ -z "$device" ]]; then
    echo "USB Ethernet gadget device not connected."
    exit 1
fi

# Wait for DHTC to get IP address
device_ips=$(ip -4 -o addr show dev "$device" 2>/dev/null | awk '{print $4}')

if ! echo "$device_ips" | grep -qx "$HOST_IP_CIDR"; then
    deadline=$((SECONDS + DEVICE_WAIT_TIMEOUT_SECONDS))
    while ! echo "$device_ips" | grep -qx "$HOST_IP_CIDR"; do
        if (( SECONDS >= deadline )); then
            break
        fi

        sleep 1
        device_ips=$(ip -4 -o addr show dev "$device" 2>/dev/null | awk '{print $4}')
    done
fi

# If DHCP failed to get IP try fallback solution
if ! echo "$device_ips" | grep -qx "$HOST_IP_CIDR"; then
    ./assign-ip.sh
    device_ips=$(ip -4 -o addr show dev "$device" 2>/dev/null | awk '{print $4}')

    if ! echo "$device_ips" | grep -qx "$HOST_IP_CIDR"; then
        echo "Unable to configure $HOST_IP on host USB interface $device."
        exit 1
    fi
fi

# Wait until device is pingable
deadline=$((SECONDS + PING_TIMEOUT_SECONDS))
while ! ping -c 1 -W 1 "$HOST" >/dev/null 2>&1; do
    if (( SECONDS >= deadline )); then
        echo "Unable to reach $HOST over USB Ethernet."
        exit 1
    fi

    sleep 1
done

# Check SSH keys if they need to be cleared
probe_output=$(ssh -o BatchMode=yes -o StrictHostKeyChecking=yes -o ConnectTimeout=3 "root@$HOST" true 2>&1)
probe_status=$?
host_key_changed_pattern="REMOTE HOST IDENTIFICATION HAS CHANGED"

if [[ "$probe_status" -ne 0 ]]; then
    if echo "$probe_output" | grep -q "$host_key_changed_pattern"; then
        ssh-keygen -R "$HOST" 2>/dev/null || true
    fi
fi

# Connect via SSH
ssh "root@$HOST"
