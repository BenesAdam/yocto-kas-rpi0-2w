SUMMARY = "USB gadget DHCP server configuration"
DESCRIPTION = "Configures dnsmasq to hand out a fixed address to the USB gadget host."
SECTION = "base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://usb-gadget.conf \
"

S = "${UNPACKDIR}"

RDEPENDS:${PN} += "dnsmasq"

do_install() {
    install -d ${D}${sysconfdir}/dnsmasq.d
    install -m 0644 ${S}/usb-gadget.conf ${D}${sysconfdir}/dnsmasq.d/usb-gadget.conf
}
