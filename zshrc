export ZSH=/home/b4k3r/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git rails ruby rvm bundler)

export PATH="/home/b4k3r/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/b4k3r/.rvm/bin"

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
source $ZSH/oh-my-zsh.sh

BASE16_SHELL="$HOME/.config/base16-shell/base16-railscasts.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

source ~/.bash_aliases
