#!/bin/bash

\cp crpd.qcow2 crpd1.qcow2
\cp crpd.qcow2 crpd2.qcow2

screen -S crpd1 -d -m qemu-system-x86_64 \
 -display none \
 -machine pc \
 --enable-kvm \
 -monitor tcp:0.0.0.0:4000,server,nowait \
 -m 2048 \
 -serial telnet:0.0.0.0:5000,server,nowait \
 -drive if=ide,file=crpd1.qcow2,index=0 \
 -device pci-bridge,chassis_nr=1,id=pci.1 \
 -device e1000,netdev=p00,mac=52:54:00:00:00:01 \
 -netdev user,id=p00,net=10.0.0.0/24,tftp=/tftpboot,hostfwd=tcp::2022-10.0.0.15:22 \
 -device e1000,netdev=p01,mac=52:54:00:00:00:02 \
 -netdev tap,ifname=tap01,id=p01,script=no,downscript=no \
 -device e1000,netdev=p02,mac=52:54:00:00:00:03 \
 -netdev tap,ifname=tap02,id=p02,script=no,downscript=no

screen -S crpd2 -d -m qemu-system-x86_64 \
 -display none \
 -machine pc \
 --enable-kvm \
 -monitor tcp:0.0.0.0:4001,server,nowait \
 -m 2048 \
 -serial telnet:0.0.0.0:5001,server,nowait \
 -drive if=ide,file=crpd2.qcow2,index=0 \
 -device pci-bridge,chassis_nr=1,id=pci.1 \
 -device e1000,netdev=p10,mac=52:54:00:00:01:01 \
 -netdev user,id=p10,net=10.0.0.0/24,tftp=/tftpboot,hostfwd=tcp::2023-10.0.0.15:22 \
 -device e1000,netdev=p11,mac=52:54:00:00:01:02 \
 -netdev tap,ifname=tap11,id=p11,script=no,downscript=no \
 -device e1000,netdev=p12,mac=52:54:00:00:01:03 \
 -netdev tap,ifname=tap12,id=p12,script=no,downscript=no
