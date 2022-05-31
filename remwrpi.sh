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
	[ -f /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.img ] || [ -f /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip ]; then
	rm /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.zip &&
	rm /var/lib/libvirt/images/2021-12-02-raspios-buster-armhf.img 2> /dev/null
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