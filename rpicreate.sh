#!/bin/sh
virt-install \
  --osinfo  linux2020 \
  --name rpios  \
  --arch armv6l \
  --machine versatilepb \
  --cpu arm1176 \
  --vcpus 1 \
  --memory 256 \
  --import  \
  --disk /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.img,format=raw,bus=virtio \
  --network bridge,source=virbr0,model=virtio  \
  --video vga \
  --graphics vnc \
  --boot 'dtb=/usr/share/rpi/qemu-rpi-kernel/versatile-pb-buster.dtb,kernel=/usr/share/rpi/qemu-rpi-kernel/kernel-qemu-4.19.50-buster,kernel_args=root=/dev/vda2 panic=1' \
  --events on_reboot=destroy
