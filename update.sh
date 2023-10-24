#!/bin/bash

echo "Updating files ..."
git pull

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.update.sh ~/.install.sh

echo "Updating plugins ..."
nvim +PlugClean
nvim +PlugUpdate

echo "Done!"
