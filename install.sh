#!/bin/bash

echo "Coping files ..."
mkdir ~/.fonts
mkdir -p ~/.config/{fontconfig/conf.d,gtk-3.0}
mkdir -p ~/.vim/{macros,after/ftplugin}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.install.sh ~/.update.sh

echo "Installing dependencies ..."
sudo apt-get -qq update
sudo apt-get install -yq zsh build-essential cmake ack-grep vim-gtk ctags python-dev python3-dev >/dev/null 2>&1

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
