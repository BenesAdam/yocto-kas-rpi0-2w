#!/bin/bash

START_TIME=$(date +%s.%N)

while true; do
    device=$(./find-device.sh 2>/dev/null)
    status=$?

    if [ "$status" -eq 0 ] && [ -n "$device" ]; then
        END_TIME=$(date +%s.%N)
        ELAPSED=$(awk "BEGIN { printf \"%.2f\", $END_TIME - $START_TIME }")
        echo "[ready] USB Ethernet gadget detected | interface: $device | time: ${ELAPSED} s"
        exit 0
    fi

    sleep 0.1
done
