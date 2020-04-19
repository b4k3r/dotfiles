#!/bin/bash

echo "Installing dependencies ..."
sudo apt-get -qq update
sudo apt-get install -yq git \
                         silversearcher-ag \
                         neovim \
                         curl \
                         zsh \
                         build-essential \
                         cmake \
                         ack-grep \
                         ctags \
                         tmux \
                         docker.io \
                         docker-compose \
                         fd-finx \
                         fzf \
                         gnupg2 \
                         neovim \
                         scdaemon \
                         tig \
                         python-dev \
                         python-pip \
                         python3-dev \
                         python3-pip >/dev/null 2>&1

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
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done!"
