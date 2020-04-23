#!/bin/bash

echo "Installing dependencies ..."
# Youbikey
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 32CBA1A9
sudo add-apt-repository ppa:yubico/stable

# Insync
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
sudo add-apt-repository "deb http://apt.insync.io/ubuntu focal non-free contrib"

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu eoan stable"

sudo apt-get -qq update
sudo apt-get install -yq git \
                         silversearcher-ag \
                         neovim \
                         gpg-agent \
                         curl \
                         zsh \
                         build-essential \
                         cmake \
                         ack-grep \
                         ctags \
                         tmux \
                         openjdk-11-jdk \
                         maven \
                         gnupg2 \
                         docker-ce docker-ce-cli containerd.io \
                         neovim \
                         insync \
                         tig \
                         yubioath-desktop \
                         python3-dev \
                         python3-pip
sudo usermod -aG docker $USER

echo "Installing Node ..."
sudo snap install node --channel=12/stable --classic

echo "Installing Golang ..."
sudo snap install go --channel=1.13/stable --classic

echo "Installing Heroku CLI ..."
sudo snap install --classic heroku

echo "Coping files ..."
mkdir ~/.fonts
mkdir -p ~/.config/{fontconfig/conf.d,nvim}
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.install_*.sh ~/.update.sh

echo "Installin FZF ..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installin fd finder ..."
wget https://github.com/sharkdp/fd/releases/download/v8.0.0/fd_8.0.0_amd64.deb -P /tmp
sudo dpkg -i /tmp/fd_8.0.0_amd64.deb

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
vim +PlugInstall

echo "Installing Docker Compose ..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installing RVM ..."
gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
rm ~/.zshrc
ln -s ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done!"
