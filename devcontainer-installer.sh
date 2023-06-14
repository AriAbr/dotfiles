#!/usr/bin/env bash

source ./lib/utils.shlib
SCRIPT_DIR="$PWD"

rm ~/.bashrc ~/.gitconfig

echo "docker" | sudo -S bash -c <(
	cat <<HERE
# Install system packages
# note we don't need git since you already have it in order to have cloned this
# repo
install_prereqs() {
	sudo nala update --raw-dpgk -v
	sudo nala install --raw-dpkg -y \
		stow \
		exuberant-ctags \
		cargo

}

center "Installing pre-reqs"
spinner install_prereqs

center "Installing modules"
spinner install core.fzf
spinner install core.gh
spinner install core.ripgrep
spinner install apps.nvim
spinner install prompts.starship

center "Stowing Dotfiles"
spinner stow bash
spinner stow git
spinner stow starship
spinner stow scripts-shared
spinner stow scripts-devcontainers
spinner stow nvim

center "Install node dependencies for scripts"
spinner "(cd scripts-shared/.local/bin && yarn install)"

center "Reloading terminal environment"
# Reload your bashrc (note, this won't reload what's in bash_profile, so you may
# need to log out and back in to ge the full effects... looking at you ssh
# server)
HERE
)
source ~/.bashrc
