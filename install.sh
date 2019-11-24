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

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
vim +PlugInstall

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done!"
