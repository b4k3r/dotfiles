#!/bin/bash

source ./common.sh

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt -qq update
sudo apt install -yq git \
                     silversearcher-ag \
                     zsh \
                     build-essential \
                     cmake \
                     ack-grep \
                     universal-ctags \
                     tmux \
                     tig \
                     yubioath-desktop \
                     docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
                     ca-certificates \
                     python3-dev \
                     python3-pip \
                     fonts-powerline

sudo usermod -aG docker b4k3r

echo "Installing Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 22

echo "Installing Golang..."
sudo snap install go --channel=latest/stable --classic

echo "Installing Simplenote..."
wget https://github.com/Automattic/simplenote-electron/releases/download/v${SIMPLENOTE_VER}/Simplenote-linux-${SIMPLENOTE_VER}-amd64.deb -P /tmp
sudo dpkg -i /tmp/Simplenote-linux-${SIMPLENOTE_VER}-amd64.deb

echo "Installing neovim..."
sudo snap install nvim --classic

echo "Coping files..."
mkdir -p ~/.vim/{swapfiles,backup}
mkdir -p ~/.config/nvim

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm -r ~/.install_*.sh ~/.update_*.sh ~/.common.sh

echo "Installin FZF..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installin fd finder ${FD_VER}..."
wget https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb -P /tmp
sudo dpkg -i /tmp/fd_${FD_VER}_amd64.deb

echo "Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing Vim plugins..."
nvim +PlugInstall

echo "Installing zsh..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git checkout zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done! Remember to restart the computer."
