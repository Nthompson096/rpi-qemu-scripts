#!/bin/bash

#Are you root?

	if [ "$EUID" -ne 0 ];
	  then echo "Please run sudo"
		    exit
else
#Check if there's a dir, if there is; I will create a dir and copy files, if not skip.

echo -e "This installer will download an image for raspberry-pi, proceed with the install? DO NOT POST ON GIT k thx."

fi
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Ok let's get started.."; break;;

		No ) echo "Goodbye."; exit;;
	esac
done

if [ ! -d /usr/share/rpi ]; then
mkdir /usr/share/rpi 2> /dev/null && chmod +x ./*.sh && cp ./* /usr/share/rpi
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

if [ -f /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip ] || [ ! -f /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip ]; then
wget -c 'https://downloads.raspberrypi.org/raspios_oldstable_armhf/images/raspios_oldstable_armhf-2021-12-02/2021-12-02-raspios-buster-armhf.zip' -P /var/lib/libvirt/images/ &&
unzip /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip -d /var/lib/libvirt/images/
fi

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