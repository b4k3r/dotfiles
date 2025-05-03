#!/bin/zsh

brew upgrade

echo "Updating files ..."
git pull

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm -r ~/.install_*.sh ~/.update_*.sh ~/.common.sh

echo "Updating plugins ..."
nvim +PlugClean
nvim +PlugUpdate

echo "Done!"
