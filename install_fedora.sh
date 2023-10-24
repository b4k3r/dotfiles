#!/bin/bash

source ./common.sh

echo "Installing dependencies ..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf -y install zsh \
                    neovim \
                    cmake \
                    gcc-c++ \
                    make \
                    python3-devel \
                    the_silver_searcher \
                    jetbrains-mono-fonts \
                    powerline-fonts \
                    direnv \
                    fd-find \
                    fzf \
                    ack \
                    tig \
                    golang \
                    yubioath-desktop \
                    util-linux-user \
                    docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo dnf module install -y nodejs:18/common

sudo usermod -aG docker b4k3r

echo "Coping files ..."
mkdir -p ~/.config/nvim
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.install.sh ~/.update.sh

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
nvim +PlugInstall

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git checkout zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

sudo systemctl enable --now docker

echo "Done! Remember to restart the computer."
