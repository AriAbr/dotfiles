#!/usr/bin/env bash

SCRIPT_DIR="$PWD"
source "$SCRIPT_DIR"/lib/utils.shlib
source "$SCRIPT_DIR"/lib/wizards.shlib
source "$SCRIPT_DIR"/lib/bootstrap.shlib

center "Github PAT Setup"
wizards.setupPAT

center "Setup Local Dev Environment"
mkdir -p ~/dev

echom "Changing git remote to ssh"
git remote set-url origin "$(git remote get-url origin | sed -E 's;https://github.com/;git@github.com:;')"

echom "All DONE!"
