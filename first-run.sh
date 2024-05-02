#!/usr/bin/env bash

SCRIPT_DIR="$PWD"
source "$SCRIPT_DIR"/lib/utils.shlib
source "$SCRIPT_DIR"/lib/wizards.shlib
source "$SCRIPT_DIR"/lib/bootstrap.shlib

center "Jira Setup"
wizards.setupJiraAPIKey

center "Github PAT Setup"
wizards.setupPAT

docker login ghcr.io -u "$(pass jira_api_user)" -p "$(pass github_pat)"

center "Setup Local Dev Environment"
mkdir -p ~/dev

(
	cd ~/dev

	git clone git@github.com:Centers-health/.env.git || echom "Already cloned .env"

	git clone git@github.com:Centers-health/enviro.git || echom "Already cloned enviro"
	(cd enviro/envs/lde && make install)

	center "Setup Core Projects"

	center "Setting up medicaid-application"
	bootstrap.medicaid-application

	center "Setting up mentor-program"
	bootstrap.mentor-program

	center "Setting up talent-acquisition"
	bootstrap.talent-acquisition

	center "Setting up centers-sites"
	bootstrap.centers-sites

	center "Setting up dynamics-cas"
	bootstrap.dynamics-cas

	center "Setting up dynamics-graph"
	bootstrap.dynamics-graph

)

echom "Changing git remote to ssh"
git remote set-url origin "$(git remote get-url origin | sed -E 's;https://github.com/;git@github.com:;')"

echom "All DONE!"
