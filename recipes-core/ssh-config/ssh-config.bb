SUMMARY = "SSH server configuration for development"
DESCRIPTION = "Configures SSH to allow empty passwords for development"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://sshd-dropin.conf"

S = "${UNPACKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/ssh/sshd_config.d
    install -m 0644 ${S}/sshd-dropin.conf ${D}${sysconfdir}/ssh/sshd_config.d/
}

FILES:${PN} = "${sysconfdir}/ssh/sshd_config.d/"
