#!/bin/bash
# install packages [v]
# install yay packages 
# fetch others required tools / repos etc
# backup
# fill submodules if required
# copy config files / link config files
# enable services



# installs the base packages 
echo "Install all packages? (y/N)";
read $REPLY

if [[ $REPLY == 'y' ]]; then
	sudo pacman -S --needed - < pacman.list.txt
else
	echo "skipping..."
fi

# install nerd fonts
echo "Install Nerd fonts? (y/N)";
read $INCLUDE_YAY 
if [[ $INCLUDE_YAY == 'y' ]]; then
	yay -S  - < yay.list.txt
else
	echo "skipping..."
fi

echo "Copying config files..."
cp -r ./.config ~/.config

#Start lightdm
systemctl start lightdm
systemctl enable lightdm

