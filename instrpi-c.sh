#!/bin/sh

echo "The installer will proceed to install the RPI virtual machine with just the console."


if [ ! -d /usr/share/rpi ]; then
mkdir /usr/share/rpi 2> /dev/null && cp ./* /usr/share/rpi
fi
		if [ ! -f /usr/bin/rpistart ]; then
		echo "Creating a start commands for virsh" && ln -sf /usr/share/rpi/rpistart.sh /usr/bin/rpistart 
		else
		[ -f /usr/bin/rpistart  ]
		fi
		#end
		if [ ! -f /usr/bin/rpishut ]; then
		echo "Creating a shutdown command for virsh" && ln -sf /usr/share/rpi/rpishut.sh /usr/bin/rpishut 
		else
		[ -f /usr/bin/rpishut  ]
		fi
		#end
		if [ ! -f /usr/bin/uninstrpi  ]; then
		echo "Creating the uninstall RPI terminal shortcut." && ln -sf /usr/share/rpi/uninstrpi.sh /usr/bin/uninstrpi 
		else
		[ -f /usr/bin/uninstrpi ]
		fi
		if [ ! -f /usr/bin/rpivga  ]; then
		echo "Creating the connection for PI via vnc." && ln -sf /usr/share/rpi/rpivga.sh /usr/bin/rpivga 
		else
		[ -f /usr/bin/rpivga ]
		fi
		if [ ! -f /usr/bin/rpicon  ]; then
		echo "Creating the connection for PI via console." && ln -sf /usr/share/rpi/rpicon.sh /usr/bin/rpicon 
		else
		[ -f /usr/bin/rpicon ]
		fi
		#end

#Will download the RPI image here. Will ask if you want to re-extract the img even if fully downloaded.

#ask if I'd want to download a version of RPI

#Links
# https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2022-01-28/2022-01-28-raspios-bullseye-arm64-lite.zip
# 
echo "Which RPI would you like to download?"

echo "Which install, this will overwrite your virtual so please uninstall first if trying to reinstall."
select yn in "Buster (non-graphic)" "Bullseye (non-graphic)" "Cancel"; do
    case $yn in
        'Buster (non-graphic)' ) echo "Choosing console install for Buster RPI" 
        wget -c 'https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-03-25/2021-03-04-raspios-buster-armhf-lite.zip' -P /var/lib/libvirt/images/ &&
		unzip /var/lib/libvirt/images/2021-03-04-raspios-buster-armhf-lite.zip -d /var/lib/libvirt/images/ && 
		mv /var/lib/libvirt/images/2021-03-04-raspios-buster-armhf-lite.img /var/lib/libvirt/images/rpi.img; break;;

		'Bullseye (non-graphic)' ) echo "Choosing console install for Bullseye RPI"  
        wget -c 'https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2022-01-28/2022-01-28-raspios-bullseye-armhf-lite.zip' -P /var/lib/libvirt/images/ &&
		unzip /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf-lite.zip -d /var/lib/libvirt/images/ && 
		mv /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf-lite.img /var/lib/libvirt/images/rpi.img; break;;
		
		Cancel ) echo "Ok, goodbye."; exit;;
	esac
done


# if [ -f /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip ] || [ ! -f /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip ]; then
# wget -c 'https://downloads.raspberrypi.org/raspios_oldstable_armhf/images/raspios_oldstable_armhf-2021-12-02/2021-12-02-raspios-buster-armhf.zip' -P /var/lib/libvirt/images/ &&
# unzip /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip -d /var/lib/libvirt/images/
# fi

#Will download the files from a repository.

if [ -d /usr/share/rpi/qemu-rpi-kernel ]; then
		 virsh --connect=qemu:///system net-start default
		 /usr/share/rpi/rpicreate-c.sh
		else
 [ ! -d /usr/share/rpi/qemu-rpi-kernel ]
 	git clone https://github.com/dhruvvyas90/qemu-rpi-kernel /usr/share/rpi/qemu-rpi-kernel &&
	virsh --connect=qemu:///system net-start default
		 /usr/share/rpi/rpicreate-c.sh
fi