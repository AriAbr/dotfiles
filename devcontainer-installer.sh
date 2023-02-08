#!/usr/bin/env bash

source ./lib/utils.shlib
SCRIPT_DIR="$PWD"

center "Installing modules"
spinner install core.fzf
spinner install core.gh
spinner install prompts.starship

center "Stowing Dotfiles"
spinner stow bash
spinner stow git
spinner stow starship
spinner stow scripts-shared
spinner stow scripts-devcontainer

center "Install node dependencies for scripts"
spinner "(cd scripts-shared/.local/bin && yarn install)"

center "Reloading terminal environment"
# Reload your bashrc (note, this won't reload what's in bash_profile, so you may
# need to log out and back in to ge the full effects... looking at you ssh
# server)
source ~/.bashrc
