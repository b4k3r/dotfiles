#!/bin/zsh

COMPOSE_VER=`curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
FD_VER=`curl -s https://api.github.com/repos/sharkdp/fd/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`

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

echo "Updating fd finder ${FD_VER} ..."
wget https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb -P /tmp
sudo dpkg -i /tmp/fd_${FD_VER}_amd64.deb

echo "Updating Docker Compose ${TER_VER} ..."
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Updating plugins ..."
vim +PlugClean
vim +PlugUpdate

echo "Done!"
