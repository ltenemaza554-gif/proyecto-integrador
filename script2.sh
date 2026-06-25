#!/bin/bash
docker --version
docker run hello-world
mkdir -p part2-kernel/buildenv
mkdir -p part2-kernel/src/boot
mkdir -p part2-kernel/targets/x86_64
cd part2-kernel
docker build -t kernel-build-buildenv buildenv/
docker run --rm -it -v "$(pwd)":/root/env kernel-build-buildenv make iso
cd part2-kernel
ls build/x86_64/
qemu-system-x86_64 -cdrom /workspaces/proyecto-integrador/part2-kernel/build/x86_64/kernel.iso -display none -monitor stdio
ls -la /workspaces/proyecto-integrador/screen.ppm
sudo apt-get install -y imagemagick -qq
convert /workspaces/proyecto-integrador/screen.ppm /workspaces/proyecto-integrador/part2-kernel/screen.png
rm -rf build
docker run --rm -it -v "$(pwd)":/root/env kernel-build-buildenv make iso
qemu-system-x86_64 -cdrom build/x86_64/kernel.iso -display none -monitor stdio
git add README.md
git commit -m "docs: README parte 2"
git pull --rebase
git push