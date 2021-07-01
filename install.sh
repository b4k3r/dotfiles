#!/bin/bash

function latest_tag () {
  curl -s https://api.github.com/repos/$1/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'
}

COMPOSE_VER=$(latest_tag 'docker/compose')
GOLANG_VER="1.16.5"
SIMPLENOTE_VER=$(latest_tag 'Automattic/simplenote-electron')
TER_VER=$(latest_tag 'hashicorp/terraform')

echo "Installing dependencies ..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install nodejs \
                    zsh \
                    vim \
                    vim-X11 \
                    cmake \
                    gcc-c++ \
                    make \
                    python3-devel \
                    the_silver_searcher \
                    jetbrains-mono-fonts \
                    direnv \
                    fd-find \
                    ack \
                    tig \
                    yubioath-desktop \
                    util-linux-user \
                    wireshark \
                    docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker,wireshark $USER


echo "Installing Simplenote ..."
wget https://github.com/Automattic/simplenote-electron/releases/download/v${SIMPLENOTE_VER}/Simplenote-linux-${SIMPLENOTE_VER}-x86_64.rpm -P /tmp
sudo dnf -y install /tmp/Simplenote-linux-${SIMPLENOTE_VER}-x86_64.rpm

echo "Installing Terraform ${TER_VER} ..."
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip -P /tmp
unzip /tmp/terraform_${TER_VER}_linux_amd64.zip
sudo mv ./terraform /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
sudo rm /tmp/terraform_${TER_VER}_linux_amd64.zip

echo "Installing Golang ${GOLANG_VER} ..."
wget https://dl.google.com/go/go${GOLANG_VER}.linux-amd64.tar.gz -P /tmp
sudo tar -C /usr/local -xzf /tmp/go${GOLANG_VER}.linux-amd64.tar.gz
mkdir -p ~/go
export PATH="$PATH:/usr/local/go/bin"

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
