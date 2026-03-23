SUMMARY = "USB Gadget Network Setup"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

do_install() {
    install -d ${D}${bindir}
    cat > ${D}${bindir}/usb-gadget-init.sh << EOF
#!/bin/sh
echo "USB gadget init started" > /dev/kmsg
modprobe dwc2
modprobe g_ether host_addr=00:00:de:ad:be:ef dev_addr=00:00:ca:fe:ba:be
echo "Modules loaded" > /dev/kmsg
sleep 8
ip addr add 192.168.7.2/24 dev usb0
ip link set usb0 up
echo "Network configured" > /dev/kmsg
echo 'root:root' | chpasswd
dropbear -B &
echo "Dropbear started" > /dev/kmsg
EOF
    chmod +x ${D}${bindir}/usb-gadget-init.sh

    install -d ${D}${sysconfdir}/init.d
    cat > ${D}${sysconfdir}/init.d/usb-gadget-network << INITSCRIPT
#!/bin/sh
case "\$1" in
    start)
        /usr/bin/usb-gadget-init.sh
        ;;
esac
INITSCRIPT
    chmod +x ${D}${sysconfdir}/init.d/usb-gadget-network

    install -d ${D}${sysconfdir}/rcS.d
    ln -sf ../init.d/usb-gadget-network ${D}${sysconfdir}/rcS.d/S30usb-gadget-network

    install -d ${D}${sysconfdir}/rc3.d
    ln -sf ../init.d/usb-gadget-network ${D}${sysconfdir}/rc3.d/S99usb-gadget-network
}

RDEPENDS:${PN} = "kmod"
