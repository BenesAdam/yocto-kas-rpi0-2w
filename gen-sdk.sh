#!/bin/bash

# Generate SDK using yocto
# (precondition: docker-build.sh)
time \
docker run -it --rm \
    --user "$(id -u):$(id -g)" \
    -v "$HOME":"$HOME" \
    -w "$(pwd)" \
    yocto-ubuntu:24.04 \
    kas shell kas.yml -c "bitbake my-image -c do_populate_sdk"
