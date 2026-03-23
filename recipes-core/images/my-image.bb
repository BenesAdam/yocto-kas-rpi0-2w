SUMMARY = "Custom minimal image for Raspberry Pi Zero 2 W"
DESCRIPTION = "Minimal image with some basic packages for Pi Zero 2 W"
LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL += "dropbear busybox-udhcpd usb-gadget-network"
EXTRA_IMAGE_FEATURES += "empty-root-password allow-root-login"

IMAGE_NAME = "my-image"
IMAGE_NAME_SUFFIX = ""
