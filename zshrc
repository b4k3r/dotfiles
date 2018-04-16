export ZSH=/Users/b4k3r/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git rails ruby bundler)

source $ZSH/oh-my-zsh.sh
source ~/.bash_aliases

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
export GOPATH=$HOME/go

export KEYTIMEOUT=1
export GPG_TTY=$(tty)

export PATH="$PATH:$HOME/.rvm/bin"
