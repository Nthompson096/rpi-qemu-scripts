#!/bin/sh

	if
	[ -f /usr/bin/rpistart ] ; then
	rm /usr/bin/rpistart
	fi
	if
	[ -f /usr/bin/rpishut ] ; then
	rm /usr/bin/rpishut
	fi

	if
	[ -f /usr/bin/uninstrpi ] ; then
	rm /usr/bin/uninstrpi
	fi
	if [ -f /usr/bin/rpivga ]; then
	rm /usr/bin/rpivga
	fi
	if [ -f /usr/bin/rpicon ]; then
	rm /usr/bin/rpicon
	fi


	if
	[ -f /var/lib/libvirt/images/rpi.img ]; then
	rm /var/lib/libvirt/images/rpi.img
else
	echo "img file not found skipping."
 	fi

		if [ -f /var/lib/libvirt/images/2020-05-27-raspios-buster-armhf.zip ]; then
			rm /var/lib/libvirt/images/2020-05-27-raspios-buster-armhf.zip
		else
			echo "buster desktop zip not found skipping"
		fi

				if [ -f /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf.zip ]; then
			rm /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf.zip
		else
			echo "bullseye desktop zip not found skipping"
		fi

				if [ -f /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf-lite.zip ]; then
			rm /var/lib/libvirt/images/2022-01-28-raspios-bullseye-armhf-lite.zip
		else
			echo "bullseye zip not found skipping"
		fi

				if [ -f /var/lib/libvirt/images/2021-03-04-raspios-buster-armhf-lite.zip ]; then
			rm /var/lib/libvirt/images/2021-03-04-raspios-buster-armhf-lite.zip
		else
			echo "buster zip not found skipping"
		fi


if [ -f /etc/libvirt/qemu/rpios.xml ]; then 
	virsh --connect=qemu:///system destroy rpios |
    virsh --connect=qemu:///system undefine rpios |&
    rm /usr/bin/remwrpi |&
    rm -r /usr/share/rpi
else
	[ ! -f /etc/libvirt/qemu/rpios.xml ]
	echo "XML documents not found, skipping." |&
	rm /usr/bin/remwrpi |&
	rm -r /usr/share/rpi
fi