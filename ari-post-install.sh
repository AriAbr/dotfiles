#!/usr/bin/env bash

# i3-gnome post install
gsettings set org.gnome.gnome-flashback desktop false

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
