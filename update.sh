#!/bin/bash

function latest_tag () {
  curl -s https://api.github.com/repos/$1/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'
}

COMPOSE_VER=$(latest_tag 'docker/compose')
GOLANG_VER="1.16.5"
SIMPLENOTE_VER=$(latest_tag 'Automattic/simplenote-electron')
TER_VER=$(latest_tag 'hashicorp/terraform')

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

echo "Updating Simplenote ${SIMPLENOTE_VER} ..."
sudo dnf -y remove simplenote
wget https://github.com/Automattic/simplenote-electron/releases/download/v${SIMPLENOTE_VER}/Simplenote-linux-${SIMPLENOTE_VER}-x86_64.rpm -P /tmp
sudo dnf -y install /tmp/Simplenote-linux-${SIMPLENOTE_VER}-x86_64.rpm

echo "Updating Golang ${GOLANG_VER} ..."
sudo rm -rf /usr/local/go
wget https://dl.google.com/go/go${GOLANG_VER}.linux-amd64.tar.gz -P /tmp
sudo tar -C /usr/local -xzf /tmp/go${GOLANG_VER}.linux-amd64.tar.gz

echo "Updating plugins ..."
vim +PlugClean
vim +PlugUpdate

echo "Done!"
