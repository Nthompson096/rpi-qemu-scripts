#!/bin/bash
if [ "$EUID" -ne 0 ];
	  then echo "Please run sudo."
		    exit
else

	  [ "$EUID" -ne 1 ];

fi

echo "Are you sure you want to completely remove Raspberry pi?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "removing virtual rpi install" && 
    /usr/share/rpi/remwrpi.sh; exit;;
        No ) exit;;
    esac
done

#echo "win95 uninstalled."
