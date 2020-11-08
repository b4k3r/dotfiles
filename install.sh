#!/bin/bash

function latest_tag () {
  curl -s https://api.github.com/repos/$1/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'
}

COMPOSE_VER=$(latest_tag 'docker/compose')
FD_VER=$(latest_tag 'sharkdp/fd')
SIMPLENOTE_VER=$(latest_tag 'Automattic/simplenote-electron')
TER_VER=$(latest_tag 'hashicorp/terraform')

echo "Installing dependencies ..."
# Youbikey
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 32CBA1A9
sudo add-apt-repository ppa:yubico/stable

# Insync
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
sudo add-apt-repository "deb http://apt.insync.io/ubuntu $(lsb_release -cs) non-free contrib"

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

sudo apt -qq update
sudo apt install -yq git \
                         silversearcher-ag \
                         zsh \
                         build-essential \
                         cmake \
                         ack-grep \
                         universal-ctags \
                         tmux \
                         docker-ce docker-ce-cli containerd.io \
                         vim vim-gtk3 \
                         insync \
                         tig \
                         yubioath-desktop \
                         python3-dev \
                         python3-pip
sudo usermod -aG docker $USER

echo "Installing Node ..."
sudo snap install node --channel=12/stable --classic

echo "Installing Golang ..."
sudo snap install go --channel=1.15/stable --classic

echo "Installing Simplenote ..."
wget https://github.com/Automattic/simplenote-electron/releases/download/v${SIMPLENOTE_VER}/Simplenote-linux-${SIMPLENOTE_VER}-amd64.deb -P /tmp
sudo dpkg -i /tmp/Simplenote-linux-${SIMPLENOTE_VER}-amd64.deb

echo "Installing Terraform ${TER_VER}..."
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip -P /tmp
unzip /tmp/terraform_${TER_VER}_linux_amd64.zip
sudo mv ./terraform /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
sudo rm /tmp/terraform_${TER_VER}_linux_amd64.zip

echo "Coping files ..."
mkdir ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.install.sh ~/.update.sh

echo "Installin FZF ..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installin fd finder ${FD_VER} ..."
wget https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb -P /tmp
sudo dpkg -i /tmp/fd_${FD_VER}_amd64.deb

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
vim +PlugInstall

echo "Installing Docker Compose ${COMPOSE_VER} ..."
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installing RVM ..."
gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git checkout zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done! Remember to restart the computer."
