#!/bin/bash

HOST="192.168.7.2"

export TERM=xterm-256color

./find-device.sh >/dev/null

if [[ $? -ne 0 ]]; then
    echo "USB Ethernet gadget device not connected."
    exit 1
fi

ping -c 1 -W 1 "$HOST" >/dev/null 2>&1 || ./assign-ip.sh

if [[ $? -ne 0 ]]; then
    echo "Unable to reach $HOST over USB Ethernet."
    exit 1
fi

probe_output=$(ssh -o BatchMode=yes -o StrictHostKeyChecking=yes -o ConnectTimeout=3 "root@$HOST" true 2>&1)
probe_status=$?

if [ "$probe_status" -ne 0 ] && echo "$probe_output" | grep -q "REMOTE HOST IDENTIFICATION HAS CHANGED"; then
    ssh-keygen -R "$HOST" 2>/dev/null || true
fi

ssh "root@$HOST"
