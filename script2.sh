#!/bin/bash
docker --version
docker run hello-world
mkdir -p part2-kernel/buildenv
mkdir -p part2-kernel/src/boot
mkdir -p part2-kernel/targets/x86_64
cd part2-kernel
docker build -t kernel-build-buildenv buildenv/
docker run --rm -it -v "$(pwd)":/root/env kernel-build-buildenv make iso
qemu-system-x86_64 -cdrom build/x86_64/kernel.iso -display curses
