#!/bin/bash

source ./common.sh

echo "Installing dependencies ..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install zsh \
                    neovim \
                    cmake \
                    gcc-c++ \
                    make \
                    python3-devel \
                    the_silver_searcher \
                    jetbrains-mono-fonts \
                    direnv \
                    fd-find \
                    ack \
                    tig \
                    yubioath-desktop \
                    util-linux-user \
                    wireshark \
                    terraform \
                    docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo dnf module install -y nodejs:18/common

sudo usermod -aG docker,wireshark b4k3r

echo "Installing Golang ${GOLANG_PKG} ..."
wget https://go.dev/dl/${GOLANG_PKG} -P /tmp
sudo tar -C /usr/local -xzf /tmp/${GOLANG_PKG}
mkdir -p ~/go
export PATH="$PATH:/usr/local/go/bin"

echo "Coping files ..."
mkdir ~/.fonts
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fontconfig/conf.d
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.install.sh ~/.update.sh

echo "Installin FZF ..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
nvim +PlugInstall

echo "Installing RVM ..."
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git checkout zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

sudo systemctl enable --now docker

echo "Done! Remember to restart the computer."
