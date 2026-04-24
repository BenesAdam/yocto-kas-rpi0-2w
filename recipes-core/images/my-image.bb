SUMMARY = "Custom minimal image for Raspberry Pi Zero 2 W"
DESCRIPTION = "Minimal image with some basic packages for Pi Zero 2 W"
LICENSE = "MIT"

inherit core-image

IMAGE_FSTYPES = "wic.bz2 wic.bmap"

IMAGE_INSTALL += " \
    packagegroup-core-boot \
    openssh \
    kernel-module-libcomposite \
    kernel-module-g-ether \
    usbinit \
    usb-dhcp \
    ssh-config \
    ssh-host-keys \
    gdbserver \
"

# GPIOD
IMAGE_INSTALL += " \
    libgpiod libgpiodcxx libgpiod-dev libgpiod-tools \
"

# I2C
IMAGE_INSTALL += " \
    i2cdev i2c-tools \
"

EXTRA_IMAGE_FEATURES += "empty-root-password allow-root-login"

IMAGE_NAME = "my-image"
IMAGE_NAME_SUFFIX = ""
