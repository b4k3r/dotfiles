#!/bin/bash

echo "Installing dependencies ..."
# Youbikey
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 32CBA1A9
sudo add-apt-repository ppa:yubico/stable

# Insync
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
sudo add-apt-repository "deb http://apt.insync.io/ubuntu $(lsb_release -cs) non-free contrib"

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt -qq update
sudo apt install -yq silversearcher-ag \
                     zsh \
                     build-essential \
                     cmake \
                     ack-grep \
                     universal-ctags \
                     tmux \
                     docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
                     insync \
                     tig \
                     yubioath-desktop \
                     python3-dev \
                     python3-pip \
                     direnv

sudo usermod -aG docker $USER

sudo snap install nvim --classic
sudo snap install go --classic
sudo snap install node --classic

echo "Coping files ..."
mkdir -p ~/.config/nvim
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.install*.sh ~/.update.sh

echo "Installin FZF ..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing fd finder ${FD_VER} ..."
wget https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb -P /tmp
sudo dpkg -i /tmp/fd_${FD_VER}_amd64.deb

cho "Installing Oh My Zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git checkout zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh
