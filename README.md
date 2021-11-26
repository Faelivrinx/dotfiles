## Dotfiles guide

***Quick Links***
- *Window manager configs*
- [Common keybindings for my configs](#keybindings)
- [Software I use](#software)

# Table of Contents

- [Overview](#overview)
- [Arch installation](#arch-installation)
- [Login and window manager](#login-and-window-manager)
- [Basic qtile configuration](#basic-qtile-configuration)
- [Basic system utilities](#basic-system-utilities)
  - [Wallpaper](#wallpaper)
  - [Fonts](#fonts)
  - [Audio](#audio)
  - [Monitors](#monitors)
  - [Storage](#storage)
  - [Network](#network)
  - [Systray](#systray)
  - [Notifications](#notifications)
  - [Xprofile](#xprofile)
- [Further configuration and tools](#further-configuration-and-tools)
  - [AUR helper](#aur-helper)
  - [Media Transfer Protocol](#media-transfer-protocol)
  - [File Manager](#file-manager)
  - [Trash](#trash)
  - [GTK Theming](#gtk-theming)
  - [Qt](#qt)
  - [Lightdm theming](#lightdm-theming)
  - [Multimedia](#multimedia)
    - [Images](#images)
    - [Video and audio](#video-and-audio)
  - [Start Hacking](#start-hacking)
- [Gallery](#gallery)
  - [Qtile](#qtile)
  - [Spectrwm](#spectrwm)
  - [Openbox](#openbox)
  - [Xmonad](#xmonad)
  - [Dwm](#dwm)
- [Keybindings](#keybindings)
  - [Windows](#windows)
  - [Apps](#apps)
- [Software](#software)
  - [Basic utilities](#basic-utilities)
  - [Fonts, theming and GTK](#fonts-theming-and-gtk)
  - [Apps](#apps-1)

# Overview

This guide will walk you through the process of building a desktop environment
starting with a fresh Arch based installation. I will assume that you are
comfortable with Linux based operating systems and command line interfaces.
This is basically how I've made the whole configuration from scratch.

# Arch installation

The guide shows installation process just after basic configuration suggested by official [Arch Wiki](https://wiki.archlinux.org/title/installation_guide). The process below is covering more advanced topic allowing you to make your's own fancy look!
Before you start make sure that you have installed all basic packages mentioned in great article created by Christian Chiarulli. If official ddocumentation doesn't meet your's expectations, you can follow his guides [PART1](https://www.chrisatmachine.com/Linux/01-Arch-Linux-Install-UEFI/). 

```bash
pacman -S networkmanager
systemctl enable NetworkManager
```

Now you can install a bootloader and test it "safely", this is how to do it on
modern hardware,
[assuming you've mounted the efi partition on /boot](https://wiki.archlinux.org/index.php/Installation_guide#Example_layouts):

```bash
pacman -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot
os-prober
grub-mkconfig -o /boot/grub/grub.cfg
```

Now you can create your user:

```bash
useradd -m username
passwd username
usermod -aG wheel,video,audio,storage username
```

In order to have root privileges we need sudo:

```bash
pacman -S sudo
```

Edit **/etc/sudoers** with nano or vim by uncommenting this line:

```bash
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL
```

Now you can reboot:

```bash
# Exit out of ISO image, unmount it and remove it
exit
umount -R /mnt
reboot
```

After logging in, your internet should be working just fine, but that's only if
your computer is plugged in. If you're on a laptop with no Ethernet ports, you
might have used **[iwctl](https://wiki.archlinux.org/index.php/Iwd#iwctl)**
during installation, but that program is not available anymore unless you have
installed it explicitly. However, we've installed
**[NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager)**,
so no problem, this is how you connect to a wireless LAN with this software:

```bash
# List all available networks
nmcli device wifi list
# Connect to your network
nmcli device wifi connect YOUR_SSID password YOUR_PASSWORD
```

Check [this page](https://wiki.archlinux.org/index.php/NetworkManager#nmcli_examples)
for other options provided by *nmcli*. The last thing we need to do before
thinking about desktop environments is installing **[Xorg](https://wiki.archlinux.org/index.php/Xorg)**:

```bash
sudo pacman -S xorg
```

# Login and window manager

First, we need to be able to login and open some programs like a browser and a
terminal, so we'll start by installing **[lighdm](https://wiki.archlinux.org/index.php/LightDM)**
and **[qtile](https://wiki.archlinux.org/index.php/Qtile)**. Lightdm will not
work unless we install a **[greeter](https://wiki.archlinux.org/index.php/LightDM#Greeter)**.
We also need
**[xterm](https://wiki.archlinux.org/index.php/Xterm)** because that's the
terminal emulator qtile will open by default, until we change the config file.
Then, a text editor is necessary for editing config files, you can use
**[vscode](https://wiki.archlinux.org/index.php/Visual_Studio_Code)** or jump
straight into **[neovim](https://wiki.archlinux.org/index.php/Neovim)** if you
have previous experience, otherwise I wouldn't suggest it. Last but not least,
we need a browser.

```bash
sudo pacman -S lightdm lightdm-gtk-greeter qtile xterm code firefox
```

Enable *lightdm* service and restart your computer, you should be able to log into
Qtile through *lightdm*.

```bash
sudo systemctl enable lightdm
reboot
```

## Wallpaper

First things first, your screen looks empty and black, so you might want to have
a wallpaper not to feel so depressed. You can open *firefox* through *rofi*
using **mod + m** and download one. Then install
**[feh](https://wiki.archlinux.org/index.php/Feh)** or
**[nitrogen](https://wiki.archlinux.org/index.php/Nitrogen)**
and and set your wallpaper:

```bash
sudo pacman -S feh
feh --bg-scale path/to/wallpaper
```

## Network

We have configured the network through *nmcli*, but a graphical frontend is
more friendly. I use
**[nm-applet](https://wiki.archlinux.org/index.php/NetworkManager#nm-applet)**:

```bash
sudo pacman -S network-manager-applet
```

## Systray

By default, you have a system tray in Qtile, but there's nothing running in it.
You can launch the programs we've just installed like so:

```bash
udiskie -t &
nm-applet &
```

Now you should see icons that you can click to configure drives and networking.
Optionally, you can install tray icons for volume and battery:

```bash
sudo pacman -S volumeicon cbatticon
volumeicon &
cbatticon &
```


## File Manager

We've done all files stuff through a terminal up to this point, but you can
install graphical or terminal based file managers.
For a graphical one, I suggest
**[thunar](https://wiki.archlinux.org/index.php/Thunar)**
and for a terminal based one,
**[ranger](https://wiki.archlinux.org/index.php/Ranger)**, although this one
is very vim-like, only use it if you know how to move in vim.

```bash
sudo pacman -S thunar ranger
```


# Keybindings

These are common keybindings to all my window managers.

## Windows

| Key                     | Action                           |
| ----------------------- | -------------------------------- |
| **mod + j**             | next window (down)               |
| **mod + k**             | next window (up)                 |
| **mod + shift + h**     | decrease master                  |
| **mod + shift + l**     | increase master                  |
| **mod + shift + j**     | move window down                 |
| **mod + shift + k**     | move window up                   |
| **mod + shift + f**     | toggle floating                  |
| **mod + tab**           | change layout                    |
| **mod + [1-9]**         | Switch to workspace N (1-9)      |
| **mod + shift + [1-9]** | Send Window to workspace N (1-9) |
| **mod + period**        | Focus next monitor               |
| **mod + comma**         | Focus previous monitor           |
| **mod + w**             | kill window                      |
| **mod + ctrl + r**      | restart wm                       |
| **mod + ctrl + q**      | quit                             |

The following keybindings will only work if you install all programs needed:


## Apps

| Key                 | Action                        |
| ------------------- | ----------------------------- |
| **mod + m**         | launch rofi                   |
| **mod + shift + m** | window nav (rofi)             |
| **mod + b**         | launch browser (firefox)      |
| **mod + e**         | launch file explorer (thunar) |
| **mod + return**    | launch terminal (alacritty)   |
| **mod + r**         | redshift                      |
| **mod + shift + r** | stop redshift                 |
| **mod + s**         | screenshot (scrot)            |

# Software

## Basic utilities

| Software                                                                                            | Utility                          |
| --------------------------------------------------------------------------------------------------- | -------------------------------- |
| **[networkmanager](https://wiki.archlinux.org/index.php/NetworkManager)**                           | Self explanatory                 |
| **[network-manager-applet](https://wiki.archlinux.org/index.php/NetworkManager#nm-applet)**         | *NetworkManager* systray         |
| **[pulseaudio](https://wiki.archlinux.org/index.php/PulseAudio)**                                   | Self explanatory                 |
| **[pavucontrol](https://www.archlinux.org/packages/extra/x86_64/pavucontrol/)**                     | *pulseaudio* GUI                 |
| **[pamixer](https://www.archlinux.org/packages/community/x86_64/pamixer/)**                         | *pulseaudio* CLI                 |
| **[brightnessctl](https://www.archlinux.org/packages/community/x86_64/brightnessctl/)**             | Laptop screen brightness         |
| **[xinit](https://wiki.archlinux.org/index.php/Xinit)**                                             | Launch programs before wm starts |
| **[libnotify](https://wiki.archlinux.org/index.php/Desktop_notifications)**                         | Desktop notifications            |
| **[notification-daemon](https://www.archlinux.org/packages/community/x86_64/notification-daemon/)** | Self explanatory                 |
| **[udiskie](https://www.archlinux.org/packages/community/any/udiskie/)**                            | Automounter                      |
| **[ntfs-3g](https://wiki.archlinux.org/index.php/NTFS-3G)**                                         | NTFS read & write                |
| **[arandr](https://www.archlinux.org/packages/community/any/arandr/)**                              | GUI for *xrandr*                 |
| **[cbatticon](https://www.archlinux.org/packages/community/x86_64/cbatticon/)**                     | Battery systray                  |
| **[volumeicon](https://www.archlinux.org/packages/community/x86_64/volumeicon/)**                   | Volume systray                   |
| **[glib2](https://www.archlinux.org/packages/core/x86_64/glib2/)**                                  | Trash                            |
| **[gvfs](https://www.archlinux.org/packages/extra/x86_64/gvfs/)**                                   | Trash for GUIs                   |

## Fonts, theming and GTK

| Software                                                                               | Utility                    |
| -------------------------------------------------------------------------------------- | -------------------------- |
| **[Picom](https://wiki.archlinux.org/index.php/Picom)**                                | Compositor for Xorg        |
| **[UbuntuMono Nerd Font](https://aur.archlinux.org/packages/nerd-fonts-ubuntu-mono/)** | Nerd Font for icons        |
| **[Material Black](https://www.gnome-look.org/p/1316887/)**                            | GTK theme and icons        |
| **[lxappearance](https://www.archlinux.org/packages/community/x86_64/lxappearance/)**  | GUI for changing themes    |
| **[nitrogen](https://wiki.archlinux.org/index.php/Nitrogen)**                          | GUI for setting wallpapers |
| **[feh](https://wiki.archlinux.org/index.php/Feh)**                                    | CLI for setting wallpapers |

## Apps

| Software                                                              | Utility                  |
| --------------------------------------------------------------------- | ------------------------ |
| **[alacritty](https://wiki.archlinux.org/index.php/Alacritty**       | Terminal emulator        |
| **[thunar](https://wiki.archlinux.org/index.php/Thunar)**             | Graphical file explorer  |
| **[ranger](https://wiki.archlinux.org/index.php/Ranger)**             | Terminal based explorer  |
| **[neovim](https://wiki.archlinux.org/index.php/Neovim)**             | Terminal based editor    |
| **[rofi](https://wiki.archlinux.org/index.php/Rofi)**                 | Menu and window switcher |
| **[scrot](https://wiki.archlinux.org/index.php/Screen_capture)**      | Screenshot               |
| **[redshift](https://wiki.archlinux.org/index.php/Redshift)**         | Take care of your eyes   |
| **[trayer](https://www.archlinux.org/packages/extra/x86_64/trayer/)** | Systray                  |
