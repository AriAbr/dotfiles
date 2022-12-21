#!/usr/bin/env bash

# Check if we have stow installed
if ! command -v stow &>/dev/null; then
	echo "You need to have GNU Stow installed."
	echo "Try \`sudo apt install stow\`"
	return 1
fi

stow locals
