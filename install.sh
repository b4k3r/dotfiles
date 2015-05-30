#!/bin/bash

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

echo "Installing dependencies ..."
sudo apt-get -qq update
sudo apt-get install -yq build-essential cmake python-dev ack-grep vim-gtk ctags >/dev/null 2>&1

echo "Installing NeoBundle ..."
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

echo "Installing plugins ...."
vim +NeoBundleInstall +qall
~/.vim/bundle/YouCompleteMe/install.sh --clang-completer  >/dev/null 2>&1

echo "Installing base16 ..."
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
git clone https://github.com/chriskempson/base16-gnome-terminal ~/.config/base16-gnome-terminal
source ~/.config/base16-gnome-terminal/base16-railscasts.dark.sh

source ~/.bashrc

echo "Done!"
