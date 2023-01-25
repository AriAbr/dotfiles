#!/usr/bin/env bash

source ./lib/utils.shlib

SCRIPT_DIR="$PWD"

# Install system packages
# note we don't need git since you already have it in order to have cloned this
# repo
install_prereqs() {
	sudo apt update
	sudo apt install -y \
		stow \
		flameshot \
		xclip \
		openssh-server \
		wget \
		gpg

}
center "Installing pre-reqs"
spinner install_prereqs

center "Installing modules"
spinner install core.gh
spinner install core.fzf
spinner install core.node_18
spinner install core.vpn
spinner install core.pass
spinner install core.docker
spinner install apps.vscode
spinner install apps.google-chrome
spinner install apps.brave-browser
spinner install prompts.starship
spinner install fonts.firacode

center "Stowing Dotfiles"
spinner stow bash
spinner stow git
spinner stow starship
spinner stow scripts-shared
# TODO: setup system bins
# - dyn-liveserve
# - dyn-lde
# spinner stow scripts-system

center "Install node dependencies for scripts"
spinner "(cd scripts-shared/.local/bin && yarn install)"

center "Reloading terminal environment"
# Reload your bashrc (note, this won't reload what's in bash_profile, so you may
# need to log out and back in to ge the full effects... looking at you ssh
# server)
source ~/.bashrc

if [[ ! -f ".first_run" ]]; then
	./first-run.sh
	touch .first_run
	read -p "System will logout now, press enter..."
	gnome-session-quit --no-prompt
fi
