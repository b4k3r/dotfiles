export ZSH="/home/b4k3r/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git ruby rvm bundler)

source $ZSH/oh-my-zsh.sh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
export KEYTIMEOUT=1

# Aliases

alias agi='sudo apt-get install'
alias agr='sudo apt-get --purge autoremove'
alias agu='sudo apt-get update'
alias agug='agu && sudo apt-get upgrade'
alias acs='apt-cache search'

alias rm='rm -rf'
alias s='sudo'

alias gt='git status -bs'
alias gu='git fetch --prune --all -t'
alias gb='git branch -a'
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"

alias tmux="TERM=xterm-256color tmux"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
