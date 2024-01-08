#!/usr/bin/env bash

source ./lib/utils.shlib

export SCRIPT_DIR="$PWD"

# Install system packages
# note we don't need git since you already have it in order to have cloned this
# repo
install_prereqs() {
    sudo apt install nala -y
    sudo nala install -y \
    cargo \
    fd-find \
    feh \
    gpg \
    libnotify-bin \
    openssh-server \
    python3-pip \
    python-is-python3 \
    sshpass \
    stow \
    ffmpeg \
    tmate \
    tmux \
    wget \
    xclip
    
    ln -svf "$(which fdfind)" ~/.local/bin/fd
}

center "Installing pre-reqs"
spinner sudo apt update
spinner install_prereqs

center "Installing modules"

# Shared
spinner install core.gh
spinner install core.fzf
spinner install prompts.starship
spinner install fonts.firacode

center "Stowing Dotfiles"
# TODO: setup system bins
# - dyn-liveserve
# - dyn-lde

# Create directories to help with stow
center "Install node dependencies for scripts"
spinner "(cd stowables/scripts-shared/.local/bin && yarn install)"

# Delete files to prevent stow error
rm ~/.bashrc
rm ~/.gitconfig

spinner stow -v -R -d stowables/ -t "$HOME" \
bash \
git \
scripts-shared \
scripts-system \
starship \
regolith \
dunst \
rofi \
picom \
poetry

center "Reloading terminal environment"
# Reload your bashrc (note, this won't reload what's in bash_profile, so you may
# need to log out and back in to ge the full effects... looking at you ssh
# server)
source ~/.bashrc

# Create folders for devcontainer caching
mkdir -p ~/.cache/devcontainer/{yarn,poetry,pre-commit}

./first-run.sh
if [[ ! -f ".first_run" ]]; then
    touch .first_run
    read -p "System will logout now, press enter..."
    gnome-session-quit --no-prompt
fi
