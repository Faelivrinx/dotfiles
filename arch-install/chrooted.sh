#!/bin/bash
echo "Setting timezone..."

ln -sf /usr/share/zoneinfo/Europe/Warsaw > /etc/localtime
hwclock --systohc

echo "Setting the keymap..."
mkdir -p /usr/local/share/kbd/keymaps
cp /run/media/usb/arch-install/dotfiles/colemakp.map.gz /usr/local/share/kbd/keymaps
loadkeys /usr/share/kbd/keymaps/colemakp.map.gz
echo KEYMAP=/usr/local/share/kbd/keymaps/colemakp.map.gz >> /etc/vconsole.conf

echo "Setting the locale..."
sleep 0.5s
vim /etc/locale.gen
locale-gen
echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US\nLC_COLLATE=en_US.UTF-8\nLC_CTYPE=en_US.UTF-8\nLC_MEASUREMENT=pl_PL.UTF-8\nLC_PAPER=pl_PL.UTF-8\nLC_TELEPHONE=pl_PL.UTF-8\nLC_TIME=en_US.UTF-8\nLC_MONETARY=en_US.UTF-8\nLC_NUMERIC=en_US.UTF-8\nLC_ALL=" >> /etc/locale.conf

echo "Setting hostname..."
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\mydomain.localhost" >> /etc/hosts

echo "Edit pacman.conf"
sleep 0.5s
vim /etc/pacman.conf
echo "Generating optimized mirrorlist..."
reflector --verbose --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo "Updating system..."
pacman -Syu

echo "Set root password"
sleep 0.5s
passwd
echo "Creating new user..."
useradd -m -g wheel dj 
passwd dj
echo "Edit visudo"
sleep 0.5s
visudo

# Boot loader
echo "Booot loader initialization"
echo "Installing packages"
pacman -S grub efibootmgr os-prober mtools

echo "install grub /boot"
grub-install ---target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo "GRUB config generating"
grub-mkconfig -o /boot/grub/grub.cfg


echo "Done"
echo "Please exit, unmount /mnt and reboot"
