#!/usr/bin/env bash

readonly SCRIPT_DIR="$PWD"
source "$SCRIPT_DIR"/lib/utils.shlib
source "$SCRIPT_DIR"/lib/wizards.shlib
source "$SCRIPT_DIR"/lib/bootstrap.shlib

# TODO: clean these up
# TODO: Differentiate output from user notices
# center "Setting up SSH keys"
# wizards.setupSSH
#
# center "Jira Setup"
# wizards.setupJiraAPIKey
#
# center "Github PAT Setup"
# wizards.setupPAT

center "Setup Local Dev Environment"
mkdir -p ~/dev

cd ~/dev

# TODO: split out .env files into .env repo
git clone git@github.com:Centers-health/.env.git

git clone git@github.com:Centers-health/enviro.git
(cd enviro/envs/lde && make install)

# TODO: Test that these setups work
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
