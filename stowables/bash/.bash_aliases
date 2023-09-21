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
alias dls="dyn-liveserve"

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
alias clone='f() { (cd ~/dev; git clone git@github.com:Centers-Health/$1.git;);}; f'

alias pc="dc exec dev pre-commit run"
alias pca="dc exec dev pre-commit run --all-files"
alias po="dc exec dev poetry"
alias ya="dc exec dev yarn"
alias dj="dc exec dev poetry run python manage.py"
alias manage="poetry run python manage.py"
