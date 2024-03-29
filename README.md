# RPI emulation via qemu/virsh

Provided is some simple scripts; feel free to modify these scripts in `/usr/share/rpi/`

the .img file is stored in `/var/lib/libvirt/images/` as an .img file, name `2021-12-02-raspios-buster-armhf.zip`.

# Prerequisite before running

1. qemu (qemu-full for arch)
2. zip utils mainly unzip on the distro of your choice.

# How to install?

Simply clone this repository with git, enter `cd` into the cloned directory and enter `sudo sh ./instrpi-sel.sh`; it will ask for how'd you'd like to interface the initial install.

When installing for console; you will instead install the lite variant of RPI for either bullseye or buster, for graphical you would get the desktop experience.

If you had installed the console route and would like to edit the virtual machine's XML files to include a graphical interface, feel free to use `sudo virsh edit rpios`;
include it the bottom before the end of `</devices>`

        
    <graphics type="vnc" port="-1" autoport="yes">
    <listen type="address"/>
    </graphics>
    </devices>

Mind you this will not prohibit you from using rpicon; which is the console shortcut for lite users.
What I'd also recommend to do is to compare a config if you have one, or just do some google-fu. If you'd want, install virt-manager with the distro of your choice.

*You cannot initialize the installer again to edit the xml doucments to add in graphics; this will not work.*

If you do not edit the XML file and instead installed the rpi system this way; you'll have to stick using `rpicon`.


# What are the commands?

to shutdown the guest machine, run rpishut, to start it up; enter rpistart. To connect to the rpi guest machine via console enter rpicon; to connect to the rpi guest via gui enter `rpivga`. to uninstall it completely enter `uninstrpi`; this will shutdown the running pi vm and it will be undefined (removed).

# How can i resize the img
                
    sudo qemu-img resize /var/lib/libvirt/images/rpi.img 10G

is a good example. You may use whichever size you'd like, just be careful and be sure the guest is shut down.

# How can I transfer the img to a drive?

you would enter this command:

    sudo dd if=/var/lib/libvirt/images/rpi.img of=/dev/sd status=progress bs=4M

Suppliment the info from the drive you are trying to flash with ``fdisk -l`` or ``blkid`` and replace /dev/sd with that instead.

I may also recommend the rpi-imager if that is available on the distro that you use; just be sure to choose custom rom.


### EoF:

[How to run the Raspberry Pi OS in a virtual machine with Qemu and Kvm](https://linuxconfig.org/how-to-run-the-raspberry-pi-os-in-a-virtual-machine-with-qemu-and-kvm) </br>
[Virtualization Administration Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/index) </br>
[dhruvvyas90 for the RPI kernel in order for this to run.](https://github.com/dhruvvyas90/qemu-rpi-kernel)

Please star this repository if you ever found this useful.
