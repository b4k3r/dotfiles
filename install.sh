#!/bin/bash

TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`

echo "Installing dependencies ..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf -y install dnf-plugins-core \
                 nodejs \
                 zsh \
                 vim \
                 golang \
                 cmake \
                 gcc-c++ \
                 make \
                 python3-devel \
                 the_silver_searcher \
                 fd-find \
                 ack \
                 tig \
                 yubioath-desktop \
                 java-11-openjdk-devel \
                 util-linux-user \
                 wireshark \
                 docker docker-compose
sudo usermod -aG docker,wireshark $USER
sudo alternatives --config java

# https://fedoraproject.org/wiki/Common_F31_bugs#Other_software_issues
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

sudo systemctl enable --now docker

echo "Installing Maven ..."
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar -C /opt -xzf /tmp/apache-maven-3.6.3-bin.tar.gz

echo "Installing Terraform ${TER_VER}..."
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip -P /tmp
unzip /tmp/terraform_${TER_VER}_linux_amd64.zip
sudo mv /tmp/terraform /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform

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
nvim +PlugInstall

echo "Installing RVM ..."
gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
git checkout zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done! Remember to restart the computer."
