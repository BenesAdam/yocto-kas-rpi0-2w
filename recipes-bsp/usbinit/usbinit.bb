SUMMARY = "Initscript for enabling USB gadget Ethernet"
DESCRIPTION = "This module allows ethernet emulation over USB, allowing for all sorts of nifty things like SSH and NFS in one go plus charging over the same wire."
SECTION = "bsp"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://usbinit"

S = "${UNPACKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "usbinit"
INITSCRIPT_PARAMS = "start 99 S ."

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${S}/usbinit ${D}${sysconfdir}/init.d/usbinit
}
