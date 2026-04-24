SUMMARY = "USB gadget Ethernet configuration"
DESCRIPTION = "Configures USB gadget Ethernet without boot-time polling."
SECTION = "bsp"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://usbinit \
           file://g_ether.conf \
           file://99-usb0-network.rules \
"

S = "${UNPACKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/modprobe.d
    install -m 0644 ${S}/g_ether.conf ${D}${sysconfdir}/modprobe.d/g_ether.conf

    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${S}/99-usb0-network.rules ${D}${sysconfdir}/udev/rules.d/99-usb0-network.rules

    install -d ${D}${sbindir}
    install -m 0755 ${S}/usbinit ${D}${sbindir}/usbinit
}

FILES:${PN} += " \
    ${sysconfdir}/modprobe.d/g_ether.conf \
    ${sysconfdir}/udev/rules.d/99-usb0-network.rules \
    ${sbindir}/usbinit \
"
