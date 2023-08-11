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
curl "https://raw.githubusercontent.com/Centers-Health/bdev-starter-script/master/starter_script.sh" | bash
```

```bash
./system-installer.sh
```
## Personalize the dotfiles

Please fill out the placeholders in the following files.

- `./git/.gitconfig`

## Setup Vscode

**Note:** we don't store vscode dotfiles, since vscode has a way to sync the config, keybindings, and extensions via github, just set it up there once, and the next time you do a fresh install you can just sync again and have everything as you left it (will also auto sync across machines for you, all linked to your github account.)

## Fork the repo

Fork this repo on github to make a personal copy of it. This way you can version
control your dotfiles


## Some house cleaning before installing

Depending on when you joined the team, you may have dm, dm2, or something else
being used as your configuration for dotfiles

TODO: create an installer that can automate this.
