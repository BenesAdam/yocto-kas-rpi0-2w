SUMMARY = "USB gadget network configuration"
DESCRIPTION = "Configures usb0 and hands out a fixed DHCP lease to the USB host."
SECTION = "base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://usb-gadget-network \
           file://99-usb0-network.rules \
           file://g_ether.conf \
           file://usb-gadget.conf \
"

S = "${UNPACKDIR}"

RDEPENDS:${PN} += "dnsmasq"

do_install() {
    install -d ${D}${sbindir}
    install -m 0755 ${S}/usb-gadget-network ${D}${sbindir}/usb-gadget-network

    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${S}/99-usb0-network.rules ${D}${sysconfdir}/udev/rules.d/99-usb0-network.rules

    install -d ${D}${sysconfdir}/modprobe.d
    install -m 0644 ${S}/g_ether.conf ${D}${sysconfdir}/modprobe.d/g_ether.conf

    install -d ${D}${sysconfdir}/dnsmasq.d
    install -m 0644 ${S}/usb-gadget.conf ${D}${sysconfdir}/dnsmasq.d/usb-gadget.conf
}

FILES:${PN} += " \
    ${sbindir}/usb-gadget-network \
    ${sysconfdir}/udev/rules.d/99-usb0-network.rules \
    ${sysconfdir}/modprobe.d/g_ether.conf \
    ${sysconfdir}/dnsmasq.d/usb-gadget.conf \
"
