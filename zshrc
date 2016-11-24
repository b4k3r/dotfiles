export ZSH=/home/b4k3r/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git rails ruby rvm bundler)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
source $ZSH/oh-my-zsh.sh

source ~/.bash_aliases

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

export KEYTIMEOUT=1

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
