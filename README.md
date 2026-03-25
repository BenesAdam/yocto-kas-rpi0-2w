# yocto-kas-rpi0-2w

Custom Linux image for Raspberry Pi Zero 2W using [Kas](https://kas.readthedocs.io/).

## Prerequisites

- Git
- Ubuntu: see Dockerfile for required packages
- Other: Docker

## Quick Start

### Ubuntu

```bash
# Install required packages
sudo apt install build-essential chrpath cpio debianutils diffstat file gawk gcc git iputils-ping libacl1 locales python3 python3-git python3-jinja2 python3-pexpect python3-pip python3-subunit socat texinfo unzip wget xz-utils zstd bmap-tools picocom

# Install kas
pip install kas

# Clone and build
git clone https://github.com/BenesAdam/yocto-kas-rpi0-2w
cd yocto-kas-rpi0-2w
kas build kas.yml
```

### Other (Docker)

```bash
git clone https://github.com/BenesAdam/yocto-kas-rpi0-2w
cd yocto-kas-rpi0-2w
./build.sh
```

## Flash

```bash
bmaptool copy build/tmp/deploy/images/raspberrypi0-2w-dev/my-image.wic.bz2 /dev/sdX
```

## SSH (USB)

```bash
ssh root@192.168.7.2
```

- User: root
- Password: (empty)

## UART

- Baud: 115200
- Interface: ttyAMA0

## Add packages

Edit `recipes-core/images/my-image.bb`:
```bitbake
IMAGE_INSTALL += " package-name"
```

## Clean

```bash
rm -rf build/tmp/
```

## System Requirements

- RAM: 8GB+ (16GB preferred)
- Disk: 100GB+

First build takes several hours. Subsequent builds are faster.

## See Also

- [Yocto Project](https://www.yoctoproject.org/)
- [Kas Documentation](https://kas.readthedocs.io/)
- [meta-raspberrypi](https://github.com/raspberrypi/meta-raspberrypi)
