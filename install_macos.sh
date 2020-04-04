#!/bin/bash

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.install_*.sh ~/.update.sh

echo "Installing Homebrew ..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing dependencies ..."
brew tap heroku/brew
brew install zsh \
             wget \
             git \
             cmake \
             ack \
             ctags \
             tmux \
             gpg \
             reattach-to-user-namespace \
             neovim \
             the_silver_searcher \
             fd \
             fzf \
             golang \
             heroku \
             awscli \
             node

echo "Installing RVM .."
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

echo "Installing Powerline fonts"
mkdir /tmp/fonts && git clone git@github.com:powerline/fonts.git /tmp/fonts
cd /tmp/fonts && ./install.sh
cd ~/dotfiles && rm /tmp/fonts

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
vim +PlugInstall

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh
$(brew --prefix)/opt/fzf/install

echo "Done!"
