export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git ruby rvm bundler docker-compose)

source $ZSH/oh-my-zsh.sh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
export GOPATH=$HOME/go

export KEYTIMEOUT=1
export GPG_TTY=$(tty)

alias gt='git status -bs'
alias gu='git fetch --prune --all -t'
alias gb='git branch -a'
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"

export PATH="$PATH:$HOME/.rvm/bin"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
 source ~/.linux.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
 source ~/.macos.zsh
fi

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
