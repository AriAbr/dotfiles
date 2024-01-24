#!/usr/bin/env bash

export SCRIPT_DIR="$PWD"
export TERM="xterm-256color"

# Exit if already have dotfiles folder (prevent conflict @ work)
if [ -d "$SCRIPT_DIR/dotfiles" ]; then
    echo "A 'dotfiles' subdirectory alreday exists. Exiting."
    exit 0
fi

source ./lib/utils.shlib

# Install system packages
# note we don't need git since you already have it in order to have cloned this
# repo
install_prereqs() {
    sudo apt install -y --ignore-missing \
    cargo \
    fd-find \
    feh \
    gpg \
    libnotify-bin \
    openssh-server \
    python3-pip \
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
spinner sudo install prompts.starship
spinner install fonts.firacode

center "Stowing Dotfiles"
# TODO: setup system bins
# - dyn-liveserve
# - dyn-lde

# Create directories to help with stow
center "Install node dependencies for scripts"
spinner "(cd stowables/scripts-shared/.local/bin && yarn install)"

spinner sudo stow -v -d stowables/ -t "$HOME" --adopt \
bash \
git \
scripts-shared \
scripts-system \
starship \
poetry
# "Opposite" of --adopt, per https://unix.stackexchange.com/a/698982
git reset --hard

center "Reloading terminal environment"
# Reload your bashrc (note, this won't reload what's in bash_profile, so you may
# need to log out and back in to ge the full effects... looking at you ssh
# server)
source ~/.bashrc

# Create folders for devcontainer caching
mkdir -p ~/.cache/devcontainer/{yarn,poetry,pre-commit}
