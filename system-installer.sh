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
	source ./lib/wizards.shlib

	# TODO: clean these up
	# TODO: Differentiate output from user notices
	center "Setting up SSH keys"
	wizards.setupSSH

	center "Jira Setup"
	wizards.setupJiraAPIKey

	center "Github PAT Setup"
	wizards.setupPAT

	center "Setup Local Dev Environment"
	mkdir -p ~/dev

	cd ~/dev

	# TODO: split out .env files into .env repo
	git clone git@github.com:Centers-health/.env.git

	git clone git@github.com:Centers-health/enviro.git
	(cd enviro/envs/lde && make install)

	# TODO: Test that these setups work
	center "Setup Core Projects"
	source ./lib/bootstrap.shlib
	bootstrap.medicaid-application
	bootstrap.mentor-program
	bootstrap.talent-acquisition
	bootstrap.dynamics-cas
	bootstrap.dynamics-graph
	bootstrap.centers-sites

	# TODO: move these into a conlfuence getting started doc, not needed here
	# center "Setup VSCODE"
	# echo " Make sure to setup vscode's sync if you have that setup."
	# echo "First time setting up vscode? Checkout our confluence page to get started:"
	# echo "https://valmardynamics.atlassian.net/wiki/spaces/DKB/pages/1474822155/How+to+setup+vscode+like+a+pro"
	# read -p "Press enter when you are finished setting up vscode..."

	# center "Setup VPN"
	# # https://valmardynamics.atlassian.net/wiki/spaces/DKB/pages/321650694/How+to+setup+VPN+on+linux
	# echo "The VPN (sonic wall) is already installed. you can run it in one of two ways."
	# echo "1. press super (the windows key) and type in 'connect tunnel'"
	# echo "2. open a terminal and run 'startctui'"
	# echo ""
	# echo "After it opens "
	# read -p "Press enter after you have connected to the VPN"

	cd "$SCRIPT_DIR"
	echo "Changing git remote to ssh"
	git remote set-url origin "$(git remote get-url origin | sed -E 's;https://github.com/;git@github.com:;')"

	docker login ghcr.io -u "$(pass jira_api_user)" -p "$(pass github_pat)"

	echo "All DONE!"
	read -p "System will logout now, press enter..."
	touch .first_run
	gnome-session-quit --no-prompt
fi
