# RPI emulation via qemu/virsh

Provided is some simple scripts; feel free to modify these scripts in `/usr/share/rpi/`

the img file is stored in `/var/lib/libvirt/images/` as an img file, name `2021-12-02-raspios-buster-armhf.zip`.

# Prerequest before running

1. qemu (qemu-full for arch)
2.virt-manager (optional) 

# How to install?

Simply clone this reposity with git, run cd into the cloned directory and run sudo sh ./instrpi-g for a graphical install or ./instrpi-c for console install (power users, lite users).

If you had installed the console route and would like to edit the virtual machine's XML files, feel free to use `sudo virsh edit rpios`;
include it the bottom before the end of `</devices>` 
`<graphics type="vnc" port="-1" autoport="yes">
  <listen type="address"/>
</graphics>` 

Mind you this will not prohibit you from using rpicon; which is the console shortcut for lite users.
What I'd also recommend to do is to compare a config if you have one, or just do some google-fu. If you'd want, install virt-manager with the distro of your choice (along with qemu). </br>
*You cannot initalize the installer again to edit the xml doucments to add in graphics; this will not work.*

If you do no edit the XML file and instead installed the rpi system this way; you'll have to stick using rpicon.


# What are the commands?

to shutdown the guest machine, run rpishut, to start it up; enter rpistart; to connect to the rpi guest machine via console enter rpicon; to connect to the rpi guest via gui enter rpivga. to uninstall it completely enter uninstrpi; will shutdown the running pi vm.

# How can i resize the img
`qemu-img resize /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.img 10G` is a good example. You may use whichever size you'd like, just be careful.



EoF:

[How to run the Raspberry Pi OS in a virtual machine with Qemu and Kvm](https://linuxconfig.org/how-to-run-the-raspberry-pi-os-in-a-virtual-machine-with-qemu-and-kvm)
[Virtualization Administration Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/index)

Please star this reposity if you ever found this useful.
