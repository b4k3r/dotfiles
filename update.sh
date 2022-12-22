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

echo "Updating Terraform ${COMPOSE_VER} ..."
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip -P /tmp
unzip /tmp/terraform_${TER_VER}_linux_amd64.zip
sudo mv ./terraform /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
sudo rm /tmp/terraform_${TER_VER}_linux_amd64.zip

echo "Updating Docker Compose ${TER_VER} ..."
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Updating Golang ${GOLANG_PKG} ..."
sudo rm -rf /usr/local/go
wget https://go.dev/dl/${GOLANG_PKG} -P /tmp
sudo tar -C /usr/local -xzf /tmp/${GOLANG_PKG}

echo "Updating plugins ..."
nvim +PlugClean
nvim +PlugUpdate

echo "Done!"
