#!/bin/bash

IMAGE="build/tmp/deploy/images/raspberrypi0-2w-dev/my-image.wic.bz2"

find_removable_disks() {
    lsblk -rndo NAME,SIZE,TYPE,TRAN | awk '$4=="usb" && $3=="disk" {print "/dev/"$1, $2}'
}

DISKS=$(find_removable_disks)

if [ -z "$DISKS" ]; then
    echo "No removable USB disk found."
    exit 1
fi

COUNT=$(echo "$DISKS" | wc -l)

if [ "$COUNT" -eq 1 ]; then
    DEVICE=$(echo "$DISKS" | awk '{print $1}')
    SIZE=$(echo "$DISKS" | awk '{print $2}')
else
    echo "Multiple disks found:"
    echo "$DISKS" | nl -w2 -s'. '
    read -p "Choose: " CHOICE
    DEVICE=$(echo "$DISKS" | sed -n "${CHOICE}p" | awk '{print $1}')
fi

echo "$IMAGE -> $DEVICE ($SIZE)"
read -p "Continue? [Y/n]: "

if [[ "$REPLY" =~ ^[Nn]$ ]]; then
    echo "Aborted"
    exit
fi

sudo bmaptool copy "$IMAGE" "$DEVICE"
echo "Done."
