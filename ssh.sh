#!/bin/bash

ssh-keygen -R 192.168.7.2 2>/dev/null || true

./assign-ip.sh

if [[ $? -ne 0 ]]; then
    exit 1
fi

export TERM=xterm-256color
ssh root@192.168.7.2
