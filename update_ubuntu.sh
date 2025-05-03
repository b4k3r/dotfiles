#!/bin/zsh

source ./common.sh

echo "Updating files..."
git pull

echo "Coping files..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm -r ~/.install_*.sh ~/.update_*.sh ~/.common.sh

echo "Updating fzf..."
cd ~/.fzf && git pull && ./install

echo "Updating fd finder ${FD_VER}..."
wget https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb -P /tmp
sudo dpkg -i /tmp/fd_${FD_VER}_amd64.deb

echo "Updating Simplenote ${SIMPLENOTE_VER}..."
wget https://github.com/Automattic/simplenote-electron/releases/download/v${SIMPLENOTE_VER}/Simplenote-linux-${SIMPLENOTE_VER}-amd64.deb -P /tmp
sudo dpkg -i /tmp/Simplenote-linux-${SIMPLENOTE_VER}-amd64.deb

echo "Updating VIM plugins..."
nvim +PlugClean
nvim +PlugUpdate
