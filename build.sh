#!/bin/sh
sudo mksquashfs rootfs rootfs-alpine.squashfs -comp xz -b 262144 -noappend -all-root;ubinize -o xg40-alpine.ubi -m 2048 -p 131072 -O 2048 ubinize.cfg
