alias l="ls --color=auto"
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias ll="ls -l --color=auto"
alias cl="clear && ls --color=auto"
alias cla="clear && ls -a --color=auto"
alias c="clear"
alias q="exit"
alias grep="grep --color=auto"

alias dc="docker-compose"
alias dca='docker attach $(dc ps | grep -o -E "[a-zA-Z0-9-]*-web\b")'
alias da='docker attach $(docker ps --format "{{.Names}}" | grep -E ".*-web$" | fzf --prompt="Select a container: ")'
alias cdd='cd ~/dev/$(ls ~/dev|fzf --prompt="Select a project: ")'
alias dev='devcontainer open ~/dev/$(ls ~/dev|fzf --prompt="Select a project: ")'
alias logx='docker logs -f $(docker ps --format {{.Names}} | fzf)'
alias logs='dc logs -f --tail 20'

# Git Log
#------------
alias gll="git log"
alias gl="git log --oneline"
alias gls="clear && git log --oneline -12"
alias glb="git log --pretty='format:%C(auto)%h%d %B' --color=always | sed '/^$/d' | less -r" # Like `gl`, but includes commit body
alias glst="git log --stat"
alias gs="git show"
alias gd="git diff"
alias ghf="git hotfix"

# Git Status / Checkout / Branch
alias g="git status"
alias gb="git branch"
alias gc="git checkout"
alias gcb="git checkout -b"
alias grc="rollcheck"

# Git Add
alias ga="git add ."
alias gca="git add . && git commit -a"

# Git Push
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpp="git pushu"
alias gpl="git pull"

# Git Fetch
alias gf="git fetch"
alias gfa="git fetch --all"

# Git Rebase
alias grb="git rebase"
alias grbi="git rebase -i"
alias gcont="git rebase --continue"
alias gabort="git rebase --abort"
alias gskip="git rebase --skip"

# Git Advanced
alias gitfix="git diff --name-only | uniq | xargs $EDITOR"
alias gmt="git mergetool"

#========================================
# source configs
#========================================
alias sbashrc="source ~/.bashrc"

alias pc="dc exec dev pre-commit run"
alias pca="dc exec dev pre-commit run --all-files"
alias po="dc exec dev poetry"
alias ya="dc exec dev yarn"
alias dj="dc exec dev poetry run python manage.py"
alias manage="poetry run python manage.py"

#========================================
# Persoanl Aliases
#========================================

alias src="source ~/.bashrc"
alias vscode-update="wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O /tmp/code_latest_amd64.deb && sudo dpkg -i /tmp/code_latest_amd64.deb && rm /tmp/code_latest_amd64.deb"
# Apps
# Based on https://github.com/phw/peek/issues/1094#issuecomment-1240497399
alias peek-22="peek -b ffmpeg"
open-i3-wksp() {
    i3-msg "workspace $@"
}
alias sensibo="xdg-open https://home.sensibo.com/#/pods && open-i3-wksp 🌎 I"

# Projects
alias dot="cd ~/dotfiles"
alias ezn="cd ~/eznashdb"

alias i3config="cd ~/.config/i3"
alias codex="code . && exit"
alias dox="vscli open && exit"

# Docker
alias dc="docker-compose"
alias dex="docker exec -it"

# Git
alias glb="git log --pretty='format:%C(auto)%h%d %B' --color=always | sed '/^$/d' | less -r"
