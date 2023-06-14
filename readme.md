# Dotfiles! Your own ones!

That's cool!

# What are dotfiles

<can someone please fill this out 😉>

# Getting started...

## Before you start

What you need
- access
    - Microsoft account (outlook)
    - github access
        - a github account
        - accepted invite to the `Centers-health` github organization.
    - Atlassian access (jira / confluence)
        - an account (will be tied to your microsoft account `something@dynamichcsolutions.com`)
- a laptop

## First commands

```shell
sudo apt update && sudo apt install git -y
# clone the repo with https
sudo groupadd docker
sudo usermod -aG docker $USER
# Reboot the computer, this is required on gnome for groups to take effect
# (don't ask me why)
sudo reboot now
# After reboot, run the system installer
./system-installer.sh
```
## Personalize the dotfiles

Please fill out the placeholders in the following files.

- `./git/.gitconfig`

**Note - ** we don't store vscode dotfiles, since vscode has a way to sync the config, keybindings, and extensions via github, just set it up there once, and the next time you do a fresh install you can just sync again and have everything as you left it (will also auto sync across machines for you, all linked to your github account.)

## Fork the repo

Fork this repo on github to make a personal copy of it. This way you can version
control your dotfiles


### Requirements
=======
Please fill out the placeholders in the following files.

- `./git/.gitconfig`

**Note - ** we don't store vscode dotfiles, since vscode has a way to sync the config, keybindings, and extensions via github, just set it up there once, and the next time you do a fresh install you can just sync again and have everything as you left it (will also auto sync across machines for you, all linked to your github account.)

### Requirements

#### Github Personal Access Token (PAT)
#### Jira API Key
Please setup your jira api key:

1. Go here https://id.atlassian.com/manage-profile/security/api-tokens
2. `pass add jira_api_key`

###
>>>>>>> f98bd5b (installer working!)

## Some house cleaning before installing

Depending on when you joined the team, you may have dm, dm2, or something else
being used as your configuration for dotfiles
