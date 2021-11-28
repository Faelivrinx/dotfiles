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

# Configuration

## Window Manager
`Bspwm` take care of windows managing. It's a tiling window manager supporting multiple monitors and easy to customize by confiugration files. In order to have a full functional interface we need also to install `sxhkd` which handle keybidings.

## Top menu
TODO: Polybar ...

## Terminal
TODO: Alacritty


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


