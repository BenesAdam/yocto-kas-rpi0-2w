#!/bin/bash

HOST="192.168.7.2"
PING_TIMEOUT_SECONDS=5

export TERM=xterm-256color

if ! ./find-device.sh >/dev/null; then
    echo "USB Ethernet gadget device not connected."
    exit 1
fi

deadline=$((SECONDS + PING_TIMEOUT_SECONDS))
while ! ping -c 1 -W 1 "$HOST" >/dev/null 2>&1; do
    if (( SECONDS >= deadline )); then
        ./assign-ip.sh
        break
    fi

    sleep 1
done

if [[ $? -ne 0 ]]; then
    echo "Unable to reach $HOST over USB Ethernet."
    exit 1
fi

probe_output=$(ssh -o BatchMode=yes -o StrictHostKeyChecking=yes -o ConnectTimeout=3 "root@$HOST" true 2>&1)
probe_status=$?
host_key_changed_pattern="REMOTE HOST IDENTIFICATION HAS CHANGED"

if [[ "$probe_status" -ne 0 ]]; then
    if echo "$probe_output" | grep -q "$host_key_changed_pattern"; then
        ssh-keygen -R "$HOST" 2>/dev/null || true
    fi
fi

ssh "root@$HOST"
