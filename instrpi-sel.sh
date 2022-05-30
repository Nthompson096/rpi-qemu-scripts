#!/bin/bash

#Are you root?

	if [ "$EUID" -ne 0 ];
	  then echo "Please run sudo"
		    exit
else
#Check if there's a dir, if there is; I will create a dir and copy files, if not skip.

echo -e "This installer will download an image for raspberry-pi, proceed with the install? please read the readme provided in the \n\
github repo. Choose 1 for graphical install or 2 for console install."

fi
select yn in "graphical" "console"; do
    case $yn in
        graphical ) echo "Choosing graphical install for RPI" |& chmod +x ./*.sh |& ./instrpi-g.sh; exit;;

		console ) echo "Choosing console install for RPI" |& chmod +x ./*.sh |& ./instrpi-c.sh; exit;;
	esac
done