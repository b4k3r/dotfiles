#!/bin/zsh

echo "Updating files ..."
git pull

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.update.sh ~/.install_*.sh

echo "Updating plugins ..."
vim +PlugClean
vim +PlugUpdate

echo "Done!"
