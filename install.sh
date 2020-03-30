#!/bin/bash

echo "Installing dependencies ..."
sudo add-apt-repository ppa:neovim-ppa/stable
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
                         gnupg2 \
                         tig \
                         python-dev \
                         python-pip \
                         python3-dev \
                         python3-pip >/dev/null 2>&1
curl -sL install-node.now.sh/lts | sudo bash

echo "Coping files ..."
mkdir ~/.fonts
mkdir -p ~/.config/{fontconfig/conf.d,nvim}
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.install.sh ~/.update.sh

echo "Installin FZF ..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installin fd finder ..."
wget https://github.com/sharkdp/fd/releases/download/v7.5.0/fd_7.5.0_amd64.deb -P /tmp
sudo dpkg -i /tmp/fd_7.5.0_amd64.deb

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
vim +PlugInstall

echo "Installing Docker ..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -u \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install -yq docker-ce docker-ce-cli containerd.io >/dev/null 2>&1
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installing RVM ..."
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "Installing Heroku CLI ..."
sudo snap install --classic heroku

echo "Installing Golang ..."
wget https://dl.google.com/go/go1.14.linux-amd64.tar.gz -P /tmp
sudo tar -C /usr/local -xzf /tmp/go1.14.linux-amd64.tar.gz
mkdir -p ~/go

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done!"
