export PATH="$HOME/.local/bin:$PATH"
export TERM=xterm-256color

[ -e "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# Setup fzf keybindings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(starship init bash)"
