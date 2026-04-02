#!/bin/bash

# Get vendor and product identificators
lsusb_string="Linux-USB Ethernet/RNDIS Gadget"
usb_identificator=$(lsusb | grep "${lsusb_string}" | awk '{print $6}')

if [[ -z $usb_identificator ]]; then
    echo "String '${lsusb_string}' not found in lsusb."
    exit 1
fi

vendor=${usb_identificator%%:*}
product=${usb_identificator##*:}

# Find basename
for net_path in /sys/class/net/*; do
    device_path=$(readlink -f "$net_path/device")

    grep -q $vendor $device_path/../idVendor 2>/dev/null
    vendor_match=$?

    grep -q $product $device_path/../idProduct 2>/dev/null
    product_match=$?

    if [[ $vendor_match -eq 0 && $product_match -eq 0 ]]; then
        basename "$net_path"
        exit 0
    fi
done

exit 2

