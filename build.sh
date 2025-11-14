#!/bin/sh
sudo rm -rf rootfs
sudo tar zxf rootfs.6.6.tar.gz
sudo mksquashfs rootfs rootfs-alpine.squashfs -comp xz -b 262144 -noappend -all-root
ubinize -o xg40-alpine-6.6.ubi -m 2048 -p 131072 -O 2048 ubinize.6.6.cfg
sudo rm -rf rootfs
sudo tar zxf rootfs.6.12.tar.gz
sudo mksquashfs rootfs rootfs-alpine.squashfs -comp xz -b 262144 -noappend -all-root
ubinize -o xg40-alpine-6.12.ubi -m 2048 -p 131072 -O 2048 ubinize.6.12.cfg

