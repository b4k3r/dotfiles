#!/bin/bash

source ./common.sh

echo "Updating files ..."
git pull

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.update.sh ~/.install.sh

echo "Updating fzf ..."
cd ~/.fzf && git pull && ./install

echo "Updating Golang ${GOLANG_PKG} ..."
sudo rm -rf /usr/local/go
wget https://go.dev/dl/${GOLANG_PKG} -P /tmp
sudo tar -C /usr/local -xzf /tmp/${GOLANG_PKG}

echo "Updating plugins ..."
nvim +PlugClean
nvim +PlugUpdate

echo "Done!"
