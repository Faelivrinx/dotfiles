#!/bin/bash
if [[ ! $(ping -c 2 archlinux.org | grep "2 received") ]]; then
  echo "No internet connectivity, exiting..."
  exit 1
fi

read -n 1 -p "Where the partitions set correctly? [y/n] > " input
if [[ $input == "n" ]]; then
  echo -e "\nExiting..."
  exit 1
fi

# update system clock 
timedatectl set-ntp true


echo "Installing base system..."
pacstrap /mnt base base-devel linux-lts linux-lts-headers linux-firmware intel-ucode lvm2 vim reflector bash-completion man-db ntfs-3g

echo "Creating a swap file..."
dd if=/dev/zero of=/mnt/swapfile bs=1M count=7629 status=progress
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile

echo "Generating fstab..."
genfstab -pU /mnt >> /mnt/etc/fstab
vim /mnt/etc/fstab

echo "Done"
echo "Please unmount the usb, and chroot into the new system"
