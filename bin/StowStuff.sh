#!/bin/bash

# Firstly, check we're on the right machine.
if [ "$HOSTNAME" =  "raspberrypi" ]; then
	echo "Wrong Script!  This is a Raspberry Pi - USer StowStuffRpi.sh instead."
	exit 1
fi

# Check a parameter was passed
if [ "$#" -ne 1 ];
then
	echo "Usage: StowStuff expects a parameter"
	exit 1
fi

# Only continue if -D or -R specified
if [ "$1" =  "-D" ]; then
	echo "Deleting Symlinks"
elif [ "$1" =  "-R" ]; then
	echo "Restowing (Del then Add) symlinks."
elif [ "$1" =  "-h" ]; then
	echo "Setup Symlinks from .dotfiles using stow"
	echo "StowStuff -D			Delete symlinks"
	echo "StowStuff -R			Restow symlinks"
	exit 1
else
	echo "Unrecognised option"
	exit 1
fi

# We passed the basic checks, lets do it
echo "Performing Stow operations"
cd ~/.dotfiles
#/usr/bin/stow $1 getmail
#/usr/bin/stow $1 i3
#/usr/bin/stow $1 mutt
/usr/bin/stow $1 ranger-rpi
/usr/bin/stow $1 rawdog
/usr/bin/stow $1 startup
#/usr/bin/stow $1 transmission-rpi
/usr/bin/stow $1 vim 




