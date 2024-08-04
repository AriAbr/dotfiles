#!/usr/bin/env bash

source ./lib/utils.shlib

export SCRIPT_DIR="$PWD"

# Install system packages
# note we don't need git since you already have it in order to have cloned this
# repo
install_prereqs() {
    sudo apt install -y \
    fd-find \
    feh \
    gpg \
    openssh-server \
    python3-pip \
    sshpass \
    stow \
    wget \
    xclip \
    nala
    # kde-standard
    # libnotify-bin \
    # python3-pip python-is-python3 \
    # autorandr \
    # dunst \
    # i3 brightnessctl gnome-screensaver feh \
    # i3status suckless-tools i3blocks rofi arandr \
    # gnome-flashback gnome-power-manager \
    # fonts-font-awesome acpi light \
    
    ln -svf "$(which fdfind)" ~/.local/bin/fd
}

center "Installing pre-reqs"
spinner sudo apt update
spinner install_prereqs

center "Installing modules"

# Shared
spinner install core.gh
spinner install core.fzf
spinner install core.homebrew
spinner install util.flameshot
# spinner install core.node_18
spinner install core.pass
spinner install core.docker
spinner install apps.vscode
spinner install apps.brave-browser
spinner install apps.spotify
# spinner install apps.onlyoffice
spinner install prompts.starship
spinner install cli.vscli
spinner install fonts.firacode
# spinner install contrib.i3-gnome
# spinner install contrib.regolith

center "Stowing Dotfiles"

# Create directories to help with stow
# center "Install node dependencies for scripts"
# spinner "(cd stowables/scripts-shared/.local/bin)"

# Delete files to prevent stow error
rm -f ~/.bashrc
rm -f ~/.gitconfig

spinner stow -v -R -d stowables/ -t "$HOME" \
bash \
git \
scripts-shared \
scripts-system \
starship \
# regolith \
# dunst \
# i3 \
# rofi \
# picom

center "Reloading terminal environment"
# Reload your bashrc (note, this won't reload what's in bash_profile, so you may
# need to log out and back in to ge the full effects... looking at you ssh
# server)
source ~/.bashrc

# Create folders for devcontainer caching
mkdir -p ~/.cache/devcontainer/{yarn,poetry,pre-commit}

./ari-post-install.sh

if [[ ! -f ".first_run" ]]; then
    touch .first_run
    ./first-run.sh
    read -p "System will logout now, press enter..."
    gnome-session-quit --no-prompt
fi
