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
 ~/.vim/bundle/YouCompleteMe/install.sh --clang-completer >/dev/null 2>&1

echo "Updating base16 ..."
cd ~/.config/base16-shell && git pull

source ~/.zshrc

echo "Done!"
