#!/bin/bash

echo "Installing dependencies ..."
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install nodejs \
                 zsh \
                 neovim \
                 python3-neovim \
                 the_silver_searcher \
                 fd-find \
                 ack \
                 nodejs \
                 ctags \
                 tig \
                 tmux \
                 yubioath-desktop \
                 java-11-openjdk \
                 util-linux-user \
                 grubby \
                 wireshark \
                 docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker,wireshark $USER
sudo alternatives --config java

# https://fedoraproject.org/wiki/Common_F31_bugs#Other_software_issues
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

sudo systemctl start docker
sudo systemctl enable docker

echo "Installing Maven ..."
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar -C /opt -xzf apache-maven-3.6.3-bin.tar.gz

echo "Installing Golang ..."
wget https://dl.google.com/go/go1.13.10.linux-amd64.tar.gz -P /tmp
sudo tar -C /usr/local -xzf /tmp/go1.13.10.linux-amd64.tar.gz
mkdir -p ~/go

echo "Installing Heroku CLI ..."
curl https://cli-assets.heroku.com/install.sh | sh

echo "Coping files ..."
mkdir ~/.fonts
mkdir -p ~/.config/{fontconfig/conf.d,nvim}
mkdir -p ~/.vim/{swapfiles,backup}

for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done
rm ~/.install_*.sh ~/.update.sh

echo "Installin FZF ..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins ...."
nvim +PlugInstall

echo "Installing Docker Compose ..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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