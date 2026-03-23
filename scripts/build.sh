#!/bin/bash

set -e

cd "$(dirname "$0")"

exec docker run -it --rm \
    --user "$(id -u):$(id -g)" \
    -v "$HOME":"$HOME" \
    -w "$(pwd)" \
    yocto-ubuntu:24.04 \
    kas build meta-myproject/kas.yml
