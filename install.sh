#!/bin/zsh

echo "Coping files ..."
for item in `git ls-files` ; do
  ln -sf ~/dotfiles/$item ~/.$item
done

rm ~/.install.sh ~/.update.sh

echo "Installing dependencies ..."
sudo apt-get -qq update
sudo apt-get install -yq zsh build-essential ack-grep vim-gtk ctags >/dev/null 2>&1

echo "Installing NeoBundle ..."
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

echo "Installing plugins ...."
vim +NeoBundleInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py

echo "Installing base16 ..."
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
git clone https://github.com/chriskempson/base16-gnome-terminal ~/.config/base16-gnome-terminal
source ~/.config/base16-gnome-terminal/base16-railscasts.dark.sh

echo "Installing zsh ..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
ln -sf ~/dotfiles/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "Done!"
