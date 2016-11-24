#!/bin/zsh

echo "Updating files ..."
git pull origin master

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.update.sh ~/.install.sh

echo "Updating plugins ..."
vim +PlugUpdate

echo "Done!"
