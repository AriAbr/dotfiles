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
		xclip \
		openssh-server \
		wget \
		gpg

}
center "Installing pre-reqs"
spinner install_prereqs

center "Installing modules"
# TODO: gh cli
# TODO: flameshot
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
	wizards.setupSSH
	wizards.setupJiraAPIKey
	wizards.setupPAT

	center "Setup Local Dev Environment"
	mkdir -p ~/dev
	cd ~/dev
	# TODO: split out .env files into .env repo
	# TODO: create a .env repo to share .env files and clone
	# ssh_clone .env

	ssh_clone enviro
	(cd enviro/envs/lde && make install)

	# TODO: Test that these setups work
	center "Setup Core Projects"
	ssh_clone medicaid-application
	(
		cd medicaid-application
		cp ~/dev/.env/medicaid-application.env .env
		docker-compose run --rm web make install
		docker-compose run --rm web poetry run python manage.py seed_db
		docker-compose run --rm web poetry run sh -c 'python echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(\"docker\", \"docker@docker.com\", \"docker\")" | python manage.py shell'
		docker-compose up -d
	)
	ssh_clone talent-acquisition
	cp ~/dev/.env/talent-acquisition.env .env
	(
		cd talent-acquisition
		cp ~/dev/.env/talent-acquisition.env .env
		docker-compose run --rm web make install
		docker-compose run --rm web poetry run python manage.py seed_db
		docker-compose run --rm web poetry run sh -c 'python echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(\"docker\", \"docker@docker.com\", \"docker\")" | python manage.py shell'
		docker-compose up -d
	)
	ssh_clone centers-sites
	(
		cd centers-sites
		cp ~/dev/.env/centers-sites.env .env
		docker-compose run --rm web make install
		docker-compose run --rm web poetry run python manage.py seed_db
		docker-compose run --rm web poetry run sh -c 'python echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(\"docker\", \"docker@docker.com\", \"docker\")" | python manage.py shell'
		docker-compose up -d
	)
	ssh_clone dynamics-cas
	(
		cd dynamics-cas
		cp ~/dev/.env/dynamics-cas.env .env
		docker-compose run --rm web make install
		docker-compose run --rm web poetry run python manage.py seed_db
		docker-compose run --rm web poetry run sh -c 'python echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(\"docker\", \"docker@docker.com\", \"docker\")" | python manage.py shell'
		docker-compose up -d
	)
	ssh_clone mentor-program
	(
		cd dynamics-cas
		cp ~/dev/.env/dynamics-cas.env .env
		docker-compose run --rm web poetry install
		docker-compose run --rm web poetry run sh -c "cd mentor-program && python manage.py migrate"
		docker-compose run --rm web poetry run sh -c 'cd mentor-program && python echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(\"docker\", \"docker@docker.com\", \"docker\")" | python manage.py shell'
		docker-compose run --rm web poetry run sh -c "cd mentor-program && python manage.py seed_db"
		docker-compose up -d
	)
	ssh_clone dynamics-graph
	(
		cd dynamics-graph
		cp ~/dev/.env/dynamics-graph.env .env
		docker-compose run --rm web yarn install
		docker-compose up -d
	)

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

	docker loging ghci.io -u "$(pass jira_api_user)" -p "$(pass github_pat)"

	echo "All DONE!"
	read -p "System will logout now, press enter..."
	touch .first_run
	gnome-session-quit --no-prompt
fi
