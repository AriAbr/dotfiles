#!/usr/bin/env bash

# python3
sudo apt install python3-pip python-is-python3 -y

# autorandr
sudo apt install autorandr -y

# nala
sudo apt install nala -y

# i3
sudo apt install i3 brightnessctl gnome-screensaver feh -y
mkdir ~/.config/i3
git clone git@github.com:AriAbr/i3-setup.git ~/.config/i3
sudo apt install i3status suckless-tools i3blocks rofi arandr -y

# i3-gnome post install
sudo apt install -y gnome-flashback gnome-power-manager
gsettings set org.gnome.gnome-flashback desktop false

# i3blocks
sudo apt install fonts-font-awesome acpi light -y
mkdir ~/.config/i3blocks
git clone git@github.com:AriAbr/i3blocks-setup.git ~/.config/i3blocks

# i3-volume
git clone https://github.com/hastinbe/i3-volume.git ~/.config/i3-volume

# i3expo-ng
(cd ~/dynamics-dotfiles/stowables/regolith/.config/i3expo/i3expo-ng && make && make install)