#!/bin/bash

echo "Installing Homebrew ..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing dependencies ..."
brew install cmake \
             ack \
             ctags \
             tmux \
             reattach-to-user-namespace \
             neovim \
             the_silver_searcher \
             fd \
             fzf \
             golang \
             awscli \
             node

brew install --cask iterm2 \
                    google-chrome \
                    slack \
                    docker \
                    insomnia \
                    insync \
                    burp-suite \
                    wireshark \
                    yubico-authenticator \
                    bitwarden

echo "Coping files ..."
mkdir -p ~/.config/nvim
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.install*.sh ~/.update.sh

echo "Installing Powerline fonts"
mkdir /tmp/fonts && git clone git@github.com:powerline/fonts.git /tmp/fonts
cd /tmp/fonts && ./install.sh
cd ~/dotfiles && rm /tmp/fonts

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
vim +PlugInstall

echo "Installing oh-my-zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git checkout zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc

$(brew --prefix)/opt/fzf/install

echo "Done!"
