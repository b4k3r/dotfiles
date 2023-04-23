#!/bin/bash

echo "Updating files ..."
git pull

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.update.sh ~/.install.sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  source ./common_linux.sh

  echo "Updating fzf ..."
  cd ~/.fzf && git pull && ./install

  echo "Updating fd finder ${FD_VER} ..."
  wget https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb -P /tmp
  sudo dpkg -i /tmp/fd_${FD_VER}_amd64.deb
elif [[ "$OSTYPE" == "darwin"* ]]; then
fi

echo "Updating plugins ..."
nvim +PlugClean
nvim +PlugUpdate

echo "Done!"
