# !/bin/bash

device=$(exec ./find-device.sh)

if [[ $? -ne 0 ]]; then
    echo "USB Etherned gadget device not connected."
    exit 1
fi

sudo ip addr replace 192.168.7.1/24 dev $device
echo "IP assigned to device: $device"
exit 0

