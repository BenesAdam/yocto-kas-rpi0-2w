#!/bin/bash

# Generate SDK using yocto
# (precondition: docker-build.sh)
docker run -it --rm \
    --user "$(id -u):$(id -g)" \
    -v "$HOME":"$HOME" \
    -w "$(pwd)" \
    yocto-ubuntu:24.04 \
    kas shell kas.yml -c "bitbake my-image -c do_populate_sdk"

if [[ $? -ne 0 ]]; then
    echo "SDK generation failed."
    exit 1
fi

sdk_path="./build/tmp/deploy/sdk/poky-glibc-x86_64-my-image-cortexa7t2hf-neon-vfpv4-raspberrypi0-2w-dev-toolchain-5.3.3.sh"

if [ ! -f $sdk_path ]; then
    echo "SDK script file '${sdk_path}' not exists."
    exit 1
fi

bash $sdk_path
