export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git ruby rvm bundler docker-compose)

source $ZSH/oh-my-zsh.sh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
export KEYTIMEOUT=1

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye > /dev/null

alias gt='git status -bs'
alias gu='git fetch --prune --all -t'
alias gb='git branch -a'
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"

alias tmux="TERM=xterm-256color tmux"

# Add RVM and Maven
export PATH="$PATH:$HOME/.rvm/bin:/opt/apache-maven-3.6.3/bin"

# Aliases
alias vim='gvim -v'
alias rm='rm -rf'
alias s='sudo'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
