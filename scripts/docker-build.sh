#!/bin/bash

# Build yocto ubuntu using Dockerfile
docker pull ubuntu:24.04
docker build -t yocto-ubuntu:24.04 .
