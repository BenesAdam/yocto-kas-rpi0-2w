#!/bin/bash

# Run yocto ubuntu in current directory
# (precondition: docker-build.sh)
time \
docker run -it --rm \
    --user "$(id -u):$(id -g)" \
    -v "$HOME":"$HOME" \
    -w "$(pwd)" \
    yocto-ubuntu:24.04 \
    kas build kas.yml
