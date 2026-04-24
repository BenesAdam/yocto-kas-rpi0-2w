SUMMARY = "Fixed SSH host keys for the development target"
DESCRIPTION = "Installs fixed SSH host keys so the target keeps a stable SSH identity across reflashes."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://ssh_host_ed25519_key \
           file://ssh_host_ed25519_key.pub \
           file://ssh_host_ecdsa_key \
           file://ssh_host_ecdsa_key.pub \
"

S = "${UNPACKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/ssh

    install -m 0600 ${S}/ssh_host_ed25519_key ${D}${sysconfdir}/ssh/ssh_host_ed25519_key
    install -m 0644 ${S}/ssh_host_ed25519_key.pub ${D}${sysconfdir}/ssh/ssh_host_ed25519_key.pub

    install -m 0600 ${S}/ssh_host_ecdsa_key ${D}${sysconfdir}/ssh/ssh_host_ecdsa_key
    install -m 0644 ${S}/ssh_host_ecdsa_key.pub ${D}${sysconfdir}/ssh/ssh_host_ecdsa_key.pub
}

FILES:${PN} = " \
    ${sysconfdir}/ssh/ssh_host_ed25519_key \
    ${sysconfdir}/ssh/ssh_host_ed25519_key.pub \
    ${sysconfdir}/ssh/ssh_host_ecdsa_key \
    ${sysconfdir}/ssh/ssh_host_ecdsa_key.pub \
"
