#!/bin/bash

set -e

./wait-for-device.sh
exec ./ssh.sh
