#!/usr/bin/env bash

sudo apt install -y  \
python3-pip python-is-python3 \
autorandr \
nala \
yad \
dunst \
i3 brightnessctl gnome-screensaver feh \
i3status suckless-tools i3blocks rofi arandr \
gnome-flashback gnome-power-manager \
fonts-font-awesome acpi light

sudo apt purge regolith-rofication

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# vscli https://github.com/michidk/vscli
brew install michidk/tools/vscli

# i3
mkdir ~/.config/i3
git clone git@github.com:AriAbr/i3-setup.git ~/.config/i3

# i3-gnome post install
gsettings set org.gnome.gnome-flashback desktop false

# i3blocks
mkdir ~/.config/i3blocks
git clone git@github.com:AriAbr/i3blocks-setup.git ~/.config/i3blocks

# i3-volume
git clone https://github.com/hastinbe/i3-volume.git ~/.config/i3-volume

# rofi theme
rofi-theme-selector

# disable ipv6
disable_ipv6_sysctl() {
  cat <<EOL | sudo tee -a /etc/sysctl.conf > /dev/null
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOL
}

activate_sysctl() {
    sudo sysctl -p
}

disable_ipv6_sysctl
activate_sysctl
