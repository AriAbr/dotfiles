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

## Fork this repo
## Setup SSH
1. Open a terminal (press the windows key and start typing "term" you should see it pop up, click on it.)
2. `ssh-keygen` (accept all the defaults with enter)
3. print your public ssh key to your terminal `cat ~/.ssh/id_rsa.pub`
4. copy it to clipboard (select it and right click and choose copy, or select it and press `ctrl+shift+c` -- mileage may vary depending on terminal emulator)
5. go to [Github SSH setup](https://github.com/settings/ssh/new)
6. paste it in and hit "Add SSH key" at the bottom. (you may need to sign into github first)
## Clone it down

Install git if you don't have it
```bash
sudo apt update && sudo apt install git -y
```

```bash
git clone <your repo ssh link>
```

## Fork the repo

Fork this repo on github to make a personal copy of it. This way you can version
control your dotfiles

## Personalize the dotfiles

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

## Some house cleaning before installing

Depending on when you joined the team, you may have dm, dm2, or something else
being used as your configuration for dotfiles