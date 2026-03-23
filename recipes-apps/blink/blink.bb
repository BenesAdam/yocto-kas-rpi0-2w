SUMMARY = "GPIO blink LED"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd

INITSCRIPT_NAME = "blink"
INITSCRIPT_PARAMS = "defaults 80"

SRC_URI = "file://blink.c \
    file://blink.service"

S = "${UNPACKDIR}"

do_compile() {
    ${CC} ${CFLAGS} ${LDFLAGS} blink.c -o blink
}

do_install() {
    ## Put into bin folder
    install -d ${D}${bindir}
    install -m 0755 blink ${D}${bindir}

    ## Start on boot
    # install -d ${D}${systemd_system_unitdir}
    # install -m 0644 blink.service ${D}${systemd_system_unitdir}
}
