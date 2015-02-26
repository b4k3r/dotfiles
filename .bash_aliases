alias agi='sudo apt-get install'
alias agr='sudo apt-get --purge autoremove'
alias agu='sudo apt-get update'
alias agug='agu && sudo apt-get upgrade'
alias acs='apt-cache search'

alias rm='rm -rf'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias s='sudo'

alias gt='git status -bs'
alias gu='git fetch --quiet --prune --all -t'
alias gb='git branch -a'
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
