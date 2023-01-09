#!/usr/bin/env bash

# Utils
install(){
	local pkgName="installers/$1.shlib"
	(source $pkgName && install)
}

spinner(){
	# TODO: add verbose override
	echo "$*..."
	temp=$(mktemp)
	eval "$*" >  "$temp" 2>&1
	if [[ "$?" -ne 0 ]]; then
		cat "$temp"
		exit 1
	fi
	echo -e "\e[1A\e[K$* DONE"
}
# source: https://unix.stackexchange.com/a/267730 with some personal modifications
center() {
  termwidth="$(tput cols)"
  padding="$(printf '%0.1s' ={1..500})"
  printf '%s%*.*s %s %*.*s%s\n' "$(tput bold)$(tput setab 4)" 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding" "$(tput sgr0)"
}

# Install system packages
# note we don't need git since you already have it in order to have cloned this
# repo
install_prereqs(){
	sudo apt update
	sudo apt install -y \
		stow \
		xclip \
		openssh-server \
		wget \
		gpg

}
center "Installing pre-reqs"
spinner install_prereqs

center "Installing modules"
# TODO: gh cli
# TODO: 
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

center "Install node dependencies for scripts"
spinner "(cd scripts-shared/.local/bin && yarn install)"

center "Reloading terminal environment"
# Reload your bashrc (note, this won't reload what's in bash_profile, so you may
# need to log out and back in to ge the full effects... looking at you ssh
# server)
source ~/.bashrc

if [[ ! -f ".first_run" ]]; then
	## SSH Keys
	center "Setting up SSH keys"
	ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
	ssh-add ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub | xclip -sel clip
	echo "SSH key created and copied to clipboard"
	echo "Paste it in the 'key' field in the form that opens in your browser"
	echo "Opening browser..."
	xdg-open https://github.com/settings/ssh/new 2>/dev/null
	echo ""
	read -p "After you've saved the key, press enter to continue..."
	echo "Great!"
	echo "Now, let's setup your jira api token"

	## Jira Api Token
	center "Jira Setup"
	xdg-open https://id.atlassian.com/manage-profile/security/api-tokens 2>/dev/null
	echo "Click 'Create API token' and copy it to your clipboard by pressing 'Copy'" 
	read -p "Press enter when you have it in your clipboard..."
	xclip -sel clip -o | pass insert --echo jira_api_token
	# TODO: get user email as well
	echo "Saved it to your password store as jira_api_token!"
	echo ""

	## Github Personal Access Token (PAT)
	center "Github PAT Setup"
	echo "Great! Now let's setup your Github Personal Access Token (PAT)"
	echo "Browser will open, create the token with 'write:packages'"
	echo "You can make the expiration date 'No Expiration'"
	xdg-open https://github.com/settings/tokens/new 2>/dev/null
	echo "Copy it to your clipboard (can press the thing next to it that looks like two overlapping squares)"
	read -p "After you have it copied to clipboard, press enter..."
	xclip -sel clip -o | pass insert --echo github_pat
	echo "Saved it to your password store as github_pat!"

	center "Setup Local Dev Environment"
	# TODO: move lde to enviro
	# TODO: clone enviro and install local dev

	center "Setup Core Projects"
	projects=( 
		"medicaid-application" 
		"talent-acquisition" 
		"dynamics-cas"
		"dynamics-graph"
		"centers-sites"
		"mentor-program"
	)
	mkdir -p ~/dev
	# TODO: clone mentor, ar, talent, cas graph
	# TODO: create a .env repo to share .env files and clone

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

	echo "All DONE!"
	read -p "System will logout now, press enter..."
	touch .first_run
	gnome-session-quit --no-prompt
	# TODO: convert https ~> ssh
	# TODO: have it do a docker login also

fi