export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git ruby bundler docker-compose direnv fzf gpg-agent direnv)

source $ZSH/oh-my-zsh.sh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
export KEYTIMEOUT=1

# Add RVM and GO
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# Aliases
alias gt='git status -bs'
alias gu='git fetch --prune --all -t'
alias gb='git branch -a'
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"

alias tmux="TERM=xterm-256color tmux"
alias vim="nvim"
alias rm='rm -rf'
alias s='sudo'

[ -f ~/.aliases ] && source ~/.aliases

# FZF
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
