export ZSH=/Users/b4k3r/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git rails ruby bundler vi-mode)

source $ZSH/oh-my-zsh.sh
source ~/.bash_aliases

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
export GOPATH=$HOME/go

export KEYTIMEOUT=1
export GPG_TTY=$(tty)

export PATH="$PATH:$HOME/.rvm/bin:$HOME/go/bin"

alias v='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
