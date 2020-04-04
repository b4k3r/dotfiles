export ZSH=/Users/b4k3r/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git ruby rvm bundler docker-compose)

source $ZSH/oh-my-zsh.sh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
export GOPATH=$HOME/go

export KEYTIMEOUT=1
export GPG_TTY=$(tty)

export PATH="$PATH:$HOME/.rvm/bin:$GOPATH"

alias v='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'

alias gt='git status -bs'
alias gu='git fetch --prune --all -t'
alias gb='git branch -a'
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

