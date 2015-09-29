#!/bin/zsh

echo "Updating files ..."
git pull origin master

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.update.sh ~/.install.sh

echo "Updating plugins ..."
vim +NeoBundleUpdate +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py

echo "Updating base16 ..."
cd ~/.config/base16-shell && git pull

source ~/.zshrc

echo "Done!"
