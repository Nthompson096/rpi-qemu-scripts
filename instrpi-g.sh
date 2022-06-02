#!/bin/sh

echo "The installer will proceed to install the RPI virtual machine with graphical capabilities."


if [ ! -d /usr/share/rpi ]; then
mkdir /usr/share/rpi 2> /dev/null && cp ./* /usr/share/rpi
fi

#Will download the RPI image here. Will ask if you want to re-extract the img even if fully downloaded.

#Ask which ver you would like to DL,
#Links
# https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2022-01-28/2022-01-28-raspios-bullseye-arm64.zip
# https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2021-05-28/2021-05-07-raspios-buster-arm64.zip

echo "This will choose the desktop env for either Buster or Bullseye; will overwrite your virtual. Uninstall if trying to reinstall."
select yn in "Buster graphical" "Bullseye graphical" "Cancel"; do
    case $yn in
        'Buster graphical' ) echo "Choosing console install for Buster RPI" 
        wget -c 'https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2020-05-28/2020-05-27-raspios-buster-armhf.zip' -P /var/lib/libvirt/images/ &&
		unzip /var/lib/libvirt/images/2020-05-27-raspios-buster-armhf.zip -d /var/lib/libvirt/images/ && 
		mv /var/lib/libvirt/images/2020-05-27-raspios-buster-armhf.img /var/lib/libvirt/images/rpi.img; break;;

		'Bullseye graphical' ) echo "Choosing console install for Bullseye RPI" 
        wget -c 'https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2022-01-28/2022-01-28-raspios-bullseye-armhf.zip' -P /var/lib/libvirt/images/ &&
		unzip /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf.zip -d /var/lib/libvirt/images/ && 
		mv /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf.img /var/lib/libvirt/images/rpi.img; break;;
		
		Cancel ) echo "Ok, goodbye."; exit;;
	esac
done

if [ ! -f /usr/bin/rpistart ]; then
		
			echo "Creating a start commands for virsh" && ln -sf /usr/share/rpi/rpistart.sh /usr/bin/rpistart 
		
		fi
		#end
		
if [ ! -f /usr/bin/rpishut ]; then
		
			echo "Creating a shutdown command for virsh" && ln -sf /usr/share/rpi/rpishut.sh /usr/bin/rpishut 
		
		fi
		#end
		
if [ ! -f /usr/bin/uninstrpi  ]; then
		
			echo "Creating the uninstall RPI terminal shortcut." && ln -sf /usr/share/rpi/uninstrpi.sh /usr/bin/uninstrpi 
		
		fi
		
if [ ! -f /usr/bin/rpivga  ]; then
		
			echo "Creating the connection for PI via vnc." && ln -sf /usr/share/rpi/rpivga.sh /usr/bin/rpivga 
		
		fi
		
if [ ! -f /usr/bin/rpicon  ]; then
		
			echo "Creating the connection for PI via console." && ln -sf /usr/share/rpi/rpicon.sh /usr/bin/rpicon
		
		fi
		#end

#Will download the files from a repository.

if [ -d /usr/share/rpi/qemu-rpi-kernel ]; then
		 virsh --connect=qemu:///system net-start default
		 /usr/share/rpi/rpicreate.sh
		else
 [ ! -d /usr/share/rpi/qemu-rpi-kernel ]
 	git clone https://github.com/dhruvvyas90/qemu-rpi-kernel /usr/share/rpi/qemu-rpi-kernel &&
	virsh --connect=qemu:///system net-start default
		 /usr/share/rpi/rpicreate.sh
fi
